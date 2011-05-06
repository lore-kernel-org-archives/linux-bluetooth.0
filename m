Return-Path: <cyrus@holtmann.org>
Subject: Re: Warning fixes for GCC 4.6
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 06 May 2011 15:48:44 +0100
In-Reply-To: <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
References: <1304620983.16101.16.camel@novo.hadess.net>
	 <BANLkTinBw-qXODF03rtcW+M3GEjK7yC3NQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1304693325.16101.34.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2011-05-06 at 10:52 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, May 5, 2011 at 9:43 PM, Bastien Nocera <hadess@hadess.net> wrote:
> > So that bluez compiles with -Werror.
> >
> > Cheers
> >
> 
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index 360218b..61c9ed1 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -71,13 +71,12 @@ static guint16 encode_discover_primary(uint16_t
> start, uint16_t end,
>  {
>  	bt_uuid_t prim;
>  	guint16 plen;
> -	uint8_t op;
> 
>  	bt_uuid16_create(&prim, GATT_PRIM_SVC_UUID);
> 
>  	if (uuid == NULL) {
> -		/* Discover all primary services */
> -		op = ATT_OP_READ_BY_GROUP_REQ;
> +		/* Discover all primary services
> +		   op = ATT_OP_READ_BY_GROUP_REQ; */
>  		plen = enc_read_by_grp_req(start, end, &prim, pdu, len);
>  	} else {
>  		uint16_t u16;
> 
> I guess we don't need the comments as enc_read_by_grp_req already
> should already do what ATT_OP_READ_BY_GROUP_REQ was meant.

I'll remove those.

> @@ -2085,9 +2084,9 @@ unsigned int a2dp_config(struct avdtp *session,
> struct a2dp_sep *sep,
>  	case AVDTP_STATE_IDLE:
>  		if (sep->type == AVDTP_SEP_TYPE_SOURCE) {
>  			l = server->sources;
> -			remote_type = AVDTP_SEP_TYPE_SINK;
> +			/* remote_type = AVDTP_SEP_TYPE_SINK; */
>  		} else {
> -			remote_type = AVDTP_SEP_TYPE_SOURCE;
> +			/* remote_type = AVDTP_SEP_TYPE_SOURCE; */
>  			l = server->sinks;
>  		}
> 
> Same here, avdtp_find_remote_sep already take care of finding a match
> so remote_type is useless.

Ditto.

> @@ -580,7 +579,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
> 
>  	server_uuid = HFP_AG_UUID;
>  	remote_uuid = HFP_HS_UUID;
> -	svclass = HANDSFREE_AGW_SVCLASS_ID;
> +	/* svclass = HANDSFREE_AGW_SVCLASS_ID; */
> 
>  	device = manager_get_device(&src, &dst, TRUE);
>  	if (!device)
> 
> Since introduced this variable was never really used, I guess it is
> safe to remove it completely too.

OK.

> @@ -1135,6 +1136,10 @@ gboolean bt_io_accept(GIOChannel *io,
> BtIOConnect connect, gpointer user_data,
>  	if (!(pfd.revents & POLLOUT)) {
>  		int ret;
>  		ret = read(sock, &c, 1);
> +		if (ret == -1) {
> +			ERROR_FAILED(err, "read", errno);
> +			return FALSE;
> +		}
>  	}
> 
> We normally use < 0, but I guess it doesn't make any difference since
> errno is actually what we should be looking for.

I'll make the change.

> @@ -94,8 +94,12 @@ static int hcrp_credit_grant(int sk, uint16_t tid,
> uint32_t credit)
>  	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
>  	memcpy(buf + HCRP_PDU_HDR_SIZE, &cp, HCRP_CREDIT_GRANT_CP_SIZE);
>  	len = write(sk, buf, HCRP_PDU_HDR_SIZE + HCRP_CREDIT_GRANT_CP_SIZE);
> +	if (len == -1)
> +		return -1;
> 
>  	len = read(sk, buf, sizeof(buf));
> +	if (len == -1)
> +		return -1;
>  	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
>  	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_GRANT_RP_SIZE);
> 
> @@ -119,8 +123,12 @@ static int hcrp_credit_request(int sk, uint16_t
> tid, uint32_t *credit)
>  	hdr.plen = htons(0);
>  	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
>  	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
> +	if (len == -1)
> +		return -1;
> 
>  	len = read(sk, buf, sizeof(buf));
> +	if (len == -1)
> +		return -1;
>  	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
>  	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_CREDIT_REQUEST_RP_SIZE);
> 
> @@ -147,8 +155,12 @@ static int hcrp_get_lpt_status(int sk, uint16_t
> tid, uint8_t *lpt_status)
>  	hdr.plen = htons(0);
>  	memcpy(buf, &hdr, HCRP_PDU_HDR_SIZE);
>  	len = write(sk, buf, HCRP_PDU_HDR_SIZE);
> +	if (len == -1)
> +		return -1;
> 
>  	len = read(sk, buf, sizeof(buf));
> +	if (len == -1)
> +		return -1;
>  	memcpy(&hdr, buf, HCRP_PDU_HDR_SIZE);
>  	memcpy(&rp, buf + HCRP_PDU_HDR_SIZE, HCRP_GET_LPT_STATUS_RP_SIZE);
> 
> Same here.

Yep.

> @@ -250,7 +250,7 @@ static int decode_key(const char *str)
>  static void send_event(int fd, uint16_t type, uint16_t code, int32_t value)
>  {
>  	struct uinput_event event;
> -	int err;
> +	int __attribute__((__unused__)) err;
> 
>  	memset(&event, 0, sizeof(event));
>  	event.type	= type;
> 
> Can't we just removed err here, Im afraid using
> __attribute__((__unused__)) is not a good practice and we should try
> to avoid using it.

We either get a warning that the return value is unused, or that we
should be checking the return value. Which one do you prefer?

