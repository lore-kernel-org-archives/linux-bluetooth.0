Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <009501d04a74$4b599c10$e20cd430$@samsung.com>
References: <1423755046-7688-1-git-send-email-bharat.panda@samsung.com>
	<009501d04a74$4b599c10$e20cd430$@samsung.com>
Date: Tue, 17 Feb 2015 14:51:32 +0200
Message-ID: <CABBYNZKmM1EF_gfDCa7CQZBUKanVr-C9CzwQVmvQLYOsLiueHA@mail.gmail.com>
Subject: Re: [PATCH v2] tools/gatt-client: print read/write error messages
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Feb 17, 2015 at 7:40 AM, Bharat Bhusan Panda
<bharat.panda@samsung.com> wrote:
> ping
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Bharat Panda
>> Sent: Thursday, February 12, 2015 9:01 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: cpgs@samsung.com; Bharat Panda
>> Subject: [PATCH v2] tools/gatt-client: print read/write error messages
>>
>> Convert error codes to error messages for read/write value error
> responses.

Please add the output, 1 or 2 messages should be enough.

>> ---
>>  tools/btgatt-client.c | 49
>> ++++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 46 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c index
>> 8bda89b..3dd75b4 100644
>> --- a/tools/btgatt-client.c
>> +++ b/tools/btgatt-client.c
>> @@ -74,6 +74,48 @@ static void print_prompt(void)
>>       fflush(stdout);
>>  }
>>
>> +static const char *ecode_to_string(uint8_t ecode) {
>> +     switch (ecode) {
>> +     case BT_ATT_ERROR_INVALID_HANDLE:
>> +             return "Invalid Handle";
>> +     case BT_ATT_ERROR_READ_NOT_PERMITTED:
>> +             return "Read Not Permitted";
>> +     case BT_ATT_ERROR_WRITE_NOT_PERMITTED:
>> +             return "Write Not Permitted";
>> +     case BT_ATT_ERROR_INVALID_PDU:
>> +             return "Invalid PDU";
>> +     case BT_ATT_ERROR_AUTHENTICATION:
>> +             return "Authentication Required";
>> +     case BT_ATT_ERROR_REQUEST_NOT_SUPPORTED:
>> +             return "Request Not Supported";
>> +     case BT_ATT_ERROR_INVALID_OFFSET:
>> +             return "Invalid Offset";
>> +     case BT_ATT_ERROR_AUTHORIZATION:
>> +             return "Authorization Required";
>> +     case BT_ATT_ERROR_PREPARE_QUEUE_FULL:
>> +             return "Prepare Write Queue Full";
>> +     case BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND:
>> +             return "Attribute Not Found";
>> +     case BT_ATT_ERROR_ATTRIBUTE_NOT_LONG:
>> +             return "Attribute Not Long";
>> +     case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION_KEY_SIZE:
>> +             return "Insuficient Encryption Key Size";
>> +     case BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN:
>> +             return "Invalid Attribute value len";
>> +     case BT_ATT_ERROR_UNLIKELY:
>> +             return "Unlikely Error";
>> +     case BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION:
>> +             return "Insufficient Encryption";
>> +     case BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE:
>> +             return "Group type Not Supported";
>> +     case BT_ATT_ERROR_INSUFFICIENT_RESOURCES:
>> +             return "Insufficient Resources";
>> +     default:
>> +             return "Unknown error type";

Probably it make sense to print the code in case it is unknown, so
perhaps instead of just %s do %s (%d) when printing the message.

>> +     }
>> +}
>> +
>>  static void att_disconnect_cb(int err, void *user_data)  {
>>       printf("Device disconnected: %s\n", strerror(err)); @@ -489,7 +531,8
>> @@ static void read_cb(bool success, uint8_t att_ecode, const uint8_t
>> *value,
>>       int i;
>>
>>       if (!success) {
>> -             PRLOG("\nRead request failed: 0x%02x\n", att_ecode);
>> +             PRLOG("\nRead request failed: %s\n",
>> +                             ecode_to_string(att_ecode));
>>               return;
>>       }
>>
>> @@ -596,7 +639,7 @@ static void write_cb(bool success, uint8_t att_ecode,
>> void *user_data)
>>       if (success) {
>>               PRLOG("\nWrite successful\n");
>>       } else {
>> -             PRLOG("\nWrite failed: 0x%02x\n", att_ecode);
>> +             PRLOG("\nWrite failed: %s\n", ecode_to_string(att_ecode));
>>       }
>>  }
>>
>> @@ -726,7 +769,7 @@ static void write_long_cb(bool success, bool
>> reliable_error, uint8_t att_ecode,
>>       } else if (reliable_error) {
>>               PRLOG("Reliable write not verified\n");
>>       } else {
>> -             PRLOG("Write failed: 0x%02x\n", att_ecode);
>> +             PRLOG("\nWrite failed: %s\n", ecode_to_string(att_ecode));
>>       }
>>  }
>>
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
