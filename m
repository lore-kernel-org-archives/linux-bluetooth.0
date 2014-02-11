Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140211111504.GE8980@aemeltch-MOBL1>
References: <1391098376-26834-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1391098376-26834-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20140204140815.GQ2930@aemeltch-MOBL1>
	<20140211111504.GE8980@aemeltch-MOBL1>
Date: Tue, 11 Feb 2014 20:37:22 +0200
Message-ID: <CABBYNZ+EABkj167NUx66p0kVU6mASDR2xYWH-Y2_sCZBiDB_+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] avrcp: Fix using incorrect buffer for SetVolume
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 11, 2014 at 1:15 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> On Tue, Feb 04, 2014 at 04:08:17PM +0200, Andrei Emeltchenko wrote:
>> On Thu, Jan 30, 2014 at 06:12:55PM +0200, Andrei Emeltchenko wrote:
>> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>> >
>> > The command requires one parameter.
>>
>> ping
>
> ping
>
>>
>> > ---
>> >  profiles/audio/avrcp.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> > index 2e1a940..128f7d3 100644
>> > --- a/profiles/audio/avrcp.c
>> > +++ b/profiles/audio/avrcp.c
>> > @@ -3706,7 +3706,7 @@ int avrcp_set_volume(struct btd_device *dev, uint8_t volume)
>> >  {
>> >     struct avrcp_server *server;
>> >     struct avrcp *session;
>> > -   uint8_t buf[AVRCP_HEADER_LENGTH + 2];
>> > +   uint8_t buf[AVRCP_HEADER_LENGTH + 1];
>> >     struct avrcp_header *pdu = (void *) buf;
>> >
>> >     server = find_server(servers, device_get_adapter(dev));
>> > --
>> > 1.8.3.2

Ive applied this one, I leave 1/3 for when we have the code properly
decoupled and patch 3/3 I end up redoing most of it to check for
invalid attributes.


-- 
Luiz Augusto von Dentz
