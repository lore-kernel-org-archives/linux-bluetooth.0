Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <2683478DEE33CD4DAF508ABCF391F6A40B415E18@DNCE02.ent.ti.com>
References: <CABBYNZL32nUYXTXTM1gCmRhGms5qGpW2uibyT5j5gDBow8Akiw@mail.gmail.com>
 <1330438817-23824-1-git-send-email-lucas.demarchi@profusion.mobi> <2683478DEE33CD4DAF508ABCF391F6A40B415E18@DNCE02.ent.ti.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 28 Feb 2012 12:54:09 -0300
Message-ID: <CAMOw1v6s4gmu4S+tHO0BgV+c0X85HjJHUc39y_T3ZPT9cRVnxw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] AVCTP: return not-implemented for unknown passthrough
To: "Malovany, Ram" <ramm@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"sunil.a.kumar@intel.com" <sunil.a.kumar@intel.com>,
	"rashmi.g.nair@intel.com" <rashmi.g.nair@intel.com>,
	"prashant.khanzode@intel.com" <prashant.khanzode@intel.com>,
	"luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ram,

On Tue, Feb 28, 2012 at 12:40 PM, Malovany, Ram <ramm@ti.com> wrote:
> Hi Lucas
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Lucas De Marchi
>> Sent: Tuesday, February 28, 2012 4:20 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: luiz.dentz@gmail.com; sunil.a.kumar@intel.com; rashmi.g.nair@intel.com;
>> prashant.khanzode@intel.com; luiz.von.dentz@intel.com; Lucas De Marchi
>> Subject: [PATCH BlueZ] AVCTP: return not-implemented for unknown passthrough
>>
>> ---
>>  audio/avctp.c |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/audio/avctp.c b/audio/avctp.c
>> index 5bd5db1..1d425eb 100644
>> --- a/audio/avctp.c
>> +++ b/audio/avctp.c
>> @@ -235,9 +235,12 @@ static size_t handle_panel_passthrough(struct avctp
>> *session,
>>               break;
>>       }
>>
>> -     if (key_map[i].name == NULL)
>> +     if (key_map[i].name == NULL) {
>>               DBG("AV/C: unknown button 0x%02X %s",
>>                                               operands[0] & 0x7F, status);
>> +             *code = AVC_CTYPE_NOT_IMPLEMENTED;
>> +             return 0;
>
> This line here is problematic in the current implementation you will reply with the wrong values at the AVRCP respond packet , when returning 0 you will truncated the Operands( State Flag , Operation Id and Operation Data Length) from the AVRCP reply.
> You need to return with the operand_count this way you will include the full response at the AVRCP profile.

I'm truncating on purpose. AFAIR not-implemented responses have no
operands. See session_cb() function:

	packet_size = AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH;
	avctp->cr = AVCTP_RESPONSE;

	if (avctp->packet_type != AVCTP_PACKET_SINGLE) {
		avc->code = AVC_CTYPE_NOT_IMPLEMENTED;
		goto done;
	}

...

done:
	ret = write(sock, buf, packet_size);
	if (ret != packet_size)
		goto failed;

	return TRUE;


Lucas De Marchi
