Return-Path: <cyrus@holtmann.org>
Message-ID: <dc2674cddc45218957359320b8f40561.squirrel@www.codeaurora.org>
In-Reply-To: <20100630082956.GA25928@jh-x301>
References: <1276795490-17262-1-git-send-email-ingas@codeaurora.org>
    <1276795490-17262-3-git-send-email-ingas@codeaurora.org>
    <20100630082956.GA25928@jh-x301>
Date: Wed, 30 Jun 2010 09:19:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] Added support for updating EIR whenever record is
     added or removed
From: ingas@codeaurora.org
To: "Johan Hedberg" <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thank you for your comprehensive comments. I will incorporate your
suggestions and investigate the feasibility of splitting the patch into
smaller functional pieces.

Inga

> Hi Inga,
>
> On Thu, Jun 17, 2010, Inga Stotland wrote:
>> ---
>>  plugins/service.c  |   18 ++++++
>>  src/adapter.c      |  148
>> ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  src/adapter.h      |    5 +-
>>  src/dbus-hci.c     |    6 +-
>>  src/sdpd-service.c |  106 +++++++++++++++++++++++++++++++------
>>  src/sdpd.h         |   20 +++++++
>>  6 files changed, 277 insertions(+), 26 deletions(-)
>
> Could you please split this patch up into smaller chunks if possible. It
> seems it has several parts which could be considered logically
> independent.
>
> Some other comments:
>
>>  void adapter_set_class_complete(bdaddr_t *bdaddr, uint8_t status)
>>  {
>>  	uint8_t class[3];
>> @@ -2677,6 +2698,7 @@ static void append_dict_valist(DBusMessageIter
>> *iter,
>>  	DBusMessageIter dict;
>>  	const char *key;
>>  	int type;
>> +	int n_elements;
>>  	void *val;
>>
>>  	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
>> @@ -2688,7 +2710,12 @@ static void append_dict_valist(DBusMessageIter
>> *iter,
>>  	while (key) {
>>  		type = va_arg(var_args, int);
>>  		val = va_arg(var_args, void *);
>> -		dict_append_entry(&dict, key, type, val);
>> +		if (type == DBUS_TYPE_ARRAY) {
>> +			n_elements = va_arg(var_args, int);
>> +			if (n_elements > 0)
>> +				dict_append_array(&dict, key, DBUS_TYPE_STRING, val, n_elements);
>> +		} else
>> +			dict_append_entry(&dict, key, type, val);
>>  		key = va_arg(var_args, char *);
>>  	}
>>
>
> It looks like this at least could be a separate patch (DBUS_TYPE_ARRAY
> support for append_dict_valist).
>
>> @@ -2719,8 +2746,106 @@ static void emit_device_found(const char *path,
>> const char *address,
>>  	g_dbus_send_message(connection, signal);
>>  }
>>
>> +
>> +static int get_uuid_count_eir (uint8_t *eir_data)
>
> Why the extra empty line? In general there should never be a need for
> two consecutive empty lines.
>
>> +{
>> +	uint8_t type;
>> +	uint8_t len = 0;
>> +	uint8_t field_len;
>> +	int count = 0;
>> +
>> +	while (len < EIR_DATA_LENGTH) {
>> +		type = eir_data[1];
>> +		field_len = eir_data[0];
>> +		if ((type == EIR_UUID16_SOME) || (type == EIR_UUID16_ALL))
>> +			count += field_len/2;
>> +		else if ((type == EIR_UUID32_SOME) || (type == EIR_UUID32_ALL))
>> +			count += field_len/4;
>> +		else if ((type == EIR_UUID128_SOME) || (type == EIR_UUID128_ALL))
>> +			count += field_len/16;
>> +		len += field_len + 1;
>> +		eir_data += field_len + 1;
>> +	}
>> +
>> +	return count;
>> +}
>
> Variables should always be declared in the minimum scope possible. In
> the above function only the count and len variables need to be in the
> function scope whereas all other should be declared inside the while
> loop.
>
>> +static void get_uuids_eir(char **uuids, uint8_t *eir_data)
>> +{
>> +	uint8_t type;
>> +	uint8_t len = 0;
>> +	uint8_t field_len = 0;
>> +	int count = 0;
>> +	int size;
>> +	uuid_t service;
>> +	gboolean service_found;
>> +
>> +	/* Count UUID16, UUID32 and UUID128 */
>> +	while (len < EIR_DATA_LENGTH) {
>> +		type = eir_data[1];
>> +		field_len =  eir_data[0];
>> +		service_found = FALSE;
>
> Same comment regarding the scope of variables.
>
>> +		if ((type == EIR_UUID16_SOME) || (type == EIR_UUID16_ALL)) {
>> +			size = 2;
>> +			service.type = SDP_UUID16;
>> +			service_found = TRUE;
>> +		} else if ((type == EIR_UUID32_SOME) || (type == EIR_UUID32_ALL)) {
>> +			size = 4;
>> +			service.type = SDP_UUID32;
>> +			service_found = TRUE;
>> +		} else if ((type == EIR_UUID128_SOME) || (type == EIR_UUID128_ALL)) {
>> +			size = 16;
>> +			service.type = SDP_UUID128;
>> +			service_found = TRUE;
>> +		}
>> +
>> +		if (service_found) {
>
> I think it'd be more readable to have
>
> if (!service_found)
> 	continue;
>
> The two last operations in the loop still need to be executed to which
> the solution would be to use a for loop and have the commands in the
> third part (i.e. for (...; ...; <whatever needs to be done every time>)
> or use a label+goto.
>
>> +			uint8_t *data = &eir_data[2];
>> +			uint16_t val16;
>> +			uint32_t val32;
>> +			int i, k;
>> +
>> +			count = field_len/size;
>
> Space before and after /
>
>> +
>> +			/* Generate uuids in SDP format (EIR data is Little Endian) */
>> +			switch (service.type) {
>> +			case SDP_UUID16:
>> +				for (i = 0; i < count; i++) {
>> +					val16 = data[1];
>> +					val16 = (val16<<8) + data[0];
>> +					service.value.uuid16 = val16;
>> +					*uuids++ = bt_uuid2string(&service);
>> +					data += size;
>> +				}
>> +				break;
>> +			case SDP_UUID32:
>> +				for (i = 0; i < count; i++) {
>> +					val32 = data[3];
>> +					for (k = size-2 ; k >= 0; k--)
>> +						val32 = (val32<<8) + data[k];
>
> Space before and after <<
>
>> +					service.value.uuid32 = val32;
>> +					*uuids++ = bt_uuid2string(&service);
>> +					data += size;
>> +				}
>> +				break;
>> +			case SDP_UUID128:
>> +				for (i = 0; i < count; i++) {
>> +					for (k = 0; k < size; k++)
>> +						service.value.uuid128.data[k] = data[size-k-1];
>
> Space before and after -
>
> You're running into trouble with the 80-character line limit while still
> keeping the code readable, but imho the core issue is just a too complex
> and long function. Please consider if you could find a way to refactor
> or rearrange it somehow.
>
>>  void adapter_emit_device_found(struct btd_adapter *adapter,
>> -				struct remote_dev_info *dev);
>> +                               struct remote_dev_info *dev, uint8_t
>> *eir_data);
>
> Looks like a mixed tabs & spaces coding style violation.
>
>> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
>> index 798e49d..5aa00f1 100644
>> --- a/src/sdpd-service.c
>> +++ b/src/sdpd-service.c
>> @@ -181,23 +181,30 @@ void create_ext_inquiry_response(const char *name,
>
> With your changes this function is growing quite ridiculously huge.
> Would there be any way to avoid that?
>
>> -		ptr += len + 2;
>> +		eir_len	 += (len + 2);
>
> Tab & space before the += (it should just be a space)
>
>>  		*ptr++ = (did_version & 0xff00) >> 8;
>> +		eir_len	 += 10;
>>  	}
>
> Same here.
>
>> +	/* Group all UUID128 types */
>> +	if (!truncated && (eir_len <= EIR_DATA_LENGTH - 2 )) {
>> +
>> +		list = services;
>> +		index = 0;
>> +
>> +		/* Store UUID128 in place, skipping first 2 bytes to insert type and
>> length later */
>
> Looks to me like this is beyond the 80-character limit.
>
>> +		uuid128 = ptr + 2;
>> +
>> +		for (; list; list = list->next) {
>> +			sdp_record_t *rec = (sdp_record_t *) list->data;
>> +
>> +			if (rec->svclass.type != SDP_UUID128)
>> +				continue;
>> +
>> +			/* Stop if not enough space to put next UUID128 */
>> +			if ((eir_len + 2 + SIZEOF_UUID128) > EIR_DATA_LENGTH) {
>> +				truncated = TRUE;
>> +				break;
>> +			}
>> +
>> +			/* Check for duplicates, EIR data is Little Endian	*/
>> +			for (i = 0; i < index; i++) {
>> +				for (k = 0; k < SIZEOF_UUID128; k++) {
>> +					if (uuid128[i*SIZEOF_UUID128 + k] !=
>
> Space before and after *
>
>> +						rec->svclass.value.uuid128.data[SIZEOF_UUID128 - k])
>
> 80-character limit exceeded
>
>> +			ptr	 = data + eir_len;
>
> Tab & space before = (it should be just a space)
>
>> +#define EIR_DATA_LENGTH  240
>> +
>> +#define EIR_FLAGS                   0x01  /* Flags */
>> +#define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more
>> available */
>> +#define EIR_UUID16_ALL              0x03  /* 16-bit UUID, all listed */
>> +#define EIR_UUID32_SOME             0x04  /* 32-bit UUID, more
>> available */
>> +#define EIR_UUID32_ALL              0x05  /* 32-bit UUID, all listed */
>> +#define EIR_UUID128_SOME            0x06  /* 128-bit UUID, more
>> available */
>> +#define EIR_UUID128_ALL             0x07  /* 128-bit UUID, all listed
>> */
>> +#define EIR_NAME_SHORT              0x08  /* shortened local name */
>> +#define EIR_NAME_COMPLETE           0x09  /* complete local name */
>> +#define EIR_TX_POWER                0x0A  /* Transmit power level */
>> +#define OOB_CLASS_OF_DEVICE         0x0D  /* Class of Device (OOB only)
>> */
>> +#define OOB_SIMPLE_PAIRING_HASH_C   0x0E  /* Simple Pairing HashC (OOB
>> only) */
>> +#define OOB_SIMPLE_PAIRING_RAND_R   0x0F  /* Simple Pairing RandR (OOB
>> only) */
>> +#define EIR_DEVICE_ID               0x10  /* Device ID */
>> +#define EIR_MANF_DATA               0xFF  /* Manufacturer Specific Data
>> */
>> +
>> +#define SIZEOF_UUID128 16
>
> Do all of these defines really need to be in the sdpd.h header? At least
> stuff like SIZEOF_UUID128 should be moved into the .c file that uses it
> (if it's really needed at all).
>
> Johan
>


