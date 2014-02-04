Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140204115549.GM2930@aemeltch-MOBL1>
References: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20140204115549.GM2930@aemeltch-MOBL1>
Date: Tue, 4 Feb 2014 14:49:02 +0200
Message-ID: <CABBYNZKTZ4WMTp26ajSOxqkNDj4D9--L2=V6YvG6QzuyqrufZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] avrcp: Avoid unneeded calculation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 4, 2014 at 1:55 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> On Thu, Jan 30, 2014 at 06:12:54PM +0200, Andrei Emeltchenko wrote:
>> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>>
>> There no need to calculate those values
>
> ping
>
>> ---
>>  profiles/audio/avrcp.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> index fa5adab..2e1a940 100644
>> --- a/profiles/audio/avrcp.c
>> +++ b/profiles/audio/avrcp.c
>> @@ -3177,7 +3177,7 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
>>       pdu->params[0] = event;
>>       pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
>>
>> -     length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
>> +     length = AVRCP_HEADER_LENGTH + AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH;
>>
>>       avctp_send_vendordep_req(session->conn, AVC_CTYPE_NOTIFY,
>>                                       AVC_SUBUNIT_PANEL, buf, length,
>> @@ -3250,7 +3250,7 @@ static void avrcp_get_capabilities(struct avrcp *session)
>>       pdu->params[0] = CAP_EVENTS_SUPPORTED;
>>       pdu->params_len = htons(AVRCP_GET_CAPABILITIES_PARAM_LENGTH);
>>
>> -     length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
>> +     length = AVRCP_HEADER_LENGTH + AVRCP_GET_CAPABILITIES_PARAM_LENGTH;
>>
>>       avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
>>                                       AVC_SUBUNIT_PANEL, buf, length,
>> --
>> 1.8.3.2

I will leave this as it for now, we will probably create a avrcp_send
helper to have this in common place.


-- 
Luiz Augusto von Dentz
