Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <747C1E83C744F44E9ACFB89FAEEC2C7B234AABDE8F@EXDCVYMBSTM005.EQ1STM.local>
References: <1341913055-19754-1-git-send-email-vani.patel@stericsson.com>
	<CABBYNZKAVFrZumVP+EyUR6=k9vAzp3T43-8u+Gevzg4d-5q64w@mail.gmail.com>
	<747C1E83C744F44E9ACFB89FAEEC2C7B234AABDE6D@EXDCVYMBSTM005.EQ1STM.local>
	<CABBYNZLgAmM6xOhN83K+sarL3StPCc5U2COSCy861ducaAWz_Q@mail.gmail.com>
	<747C1E83C744F44E9ACFB89FAEEC2C7B234AABDE8F@EXDCVYMBSTM005.EQ1STM.local>
Date: Wed, 18 Jul 2012 14:09:47 +0300
Message-ID: <CABBYNZK-mE_Bc9t8bW6kV=ARwttO4Q5Lxh8-Nxy7w-0hu1sRGQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 5/5] AVRCP: Add handler for browsing pdu
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vani-dineshbhai PATEL X <vani.patel@stericsson.com>
Cc: User Name <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>,
	Vani <vani273@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vani,

On Wed, Jul 18, 2012 at 2:07 PM, Vani-dineshbhai PATEL X
<vani.patel@stericsson.com> wrote:
> Hi Luiz,
>
>> -----Original Message-----
>> From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com]
>> Sent: Wednesday, July 18, 2012 4:35 PM
>> To: Vani-dineshbhai PATEL X
>> Cc: User Name; Lucas De Marchi; Joohi RASTOGI; Vani
>> Subject: Re: [PATCH BlueZ 5/5] AVRCP: Add handler for browsing pdu
>>
>> Hi Vani,
>>
>> On Wed, Jul 18, 2012 at 1:49 PM, Vani-dineshbhai PATEL X
>> <vani.patel@stericsson.com> wrote:
>> >> This is probably not necessary as the header should only be needed
>> >> inside avrcp.c you don't need to make it public.
>> >>
>> > AVRCP_BROWSING_HEADER_LENGTH is being used in
>> session_browsing_cb function.
>> > Avrcp_browsing_header is not used. I will remove it from here.
>>
>> But why you are using AVRCP_BROWSING_HEADER_LENGTH inside avctp.c?
>> There you should only parse the avctp header not its contents/pdu.
>>
> Yes, you are correct in pointing that out. I need to remove that. I will do the needful.

One important detail I forget to mention, we should first add support
for browsing channel in hcidump before we start pushing this changes
so we can check if the code is really working as intended.

-- 
Luiz Augusto von Dentz
