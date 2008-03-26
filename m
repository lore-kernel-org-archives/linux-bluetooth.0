Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30803260004v5d3a934bp20fd07653ffc91e0@mail.gmail.com>
Date: Wed, 26 Mar 2008 15:04:35 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <000901c88f0b$09c88e90$832fc70a@dlh.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_16113_10581925.1206515075405"
References: <194c6ea30803252300o387570b1s8b2ba96f01d7a462@mail.gmail.com>
	<000901c88f0b$09c88e90$832fc70a@dlh.st.com>
Subject: Re: [Bluez-users] How to enable eSCO in linux 2.6.18?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

------=_Part_16113_10581925.1206515075405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey buddy:

 Yes, i'm using a minikit without a motherboard(I don't have a ST
motherboard in hand : ( ). I connect the minikit to my CPU on the
development board with both UART and PCM interface.The version of the
chip is STLC2500C R4.2. I also have ssf file (which can be loaded into
the chip with certain settings)configured with the pcm settings.Please
see the attached file.
 I'll check out my ssf file settings to make sure there's nothing
wrong with my pcm interface settings according to the spec of my
CPU/STLC2500C.Other than that , i have no idea why there's no sound
coming out of the bluetooth headset.....

Thanks!!

semiyd

2008/3/26, Sumeet VERMA <sumeet.verma@st.com>:
> Hi
> Are you using a minikit? What is the version of STLC2500 chip you are using?
> In case you are using minikit along with motherboard you have to enable the
> codec. Otherwise you will not hear any sound.
>
> Regards,
> Sumeet
>
> -----Original Message-----
> From: bluez-users-bounces@lists.sourceforge.net
> [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of dong yan
> Sent: Wednesday, March 26, 2008 11:30 AM
> To: BlueZ users
> Subject: Re: [Bluez-users] How to enable eSCO in linux 2.6.18?
>
> Hi Sumeet VERMA:
>
>   Thanks a lot!
>   As a matter of fact , im using ST's bluetooth chip STLC2500. This chip
> can't establish SCO connections under linux 2.6.18, so i had to try eSCO
> connection.....that's why i want this esco patch.  i applied your patch and
> eSCO seems to be connected. But still there's no sound coming out of my
> bluetooth headset...
> When i tried to disconnect the esco channel , hcid reports an error.....
> Please refer to the details in this log:
> (I use 'hstest' from bluez-utils to test the SCO/eSCO.)
>
>  $ hstest play /tmp1/1.wav 00:0D:3C:EB:53:F0 1 Voice setting: 0x0060
> hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
> hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
> RFCOMM channel connected
> KERNEL:sco_connect(): type=2,eSCO
>
> SCO audio channel connected (handle 8, mtu 60)
> hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
>
>
> / $
> / $ hcid[173]: Disconnection failed: 0x0c
>
> At the sametime , if i use another  USB bluetooth module instead of STLC2500
> , i can hear the music with my bluetooth headset after established SCO
> connection.
>
> Please, let me know if you have any other suggestions,thanks!!
>
> semiyd
>
>
> 2008/3/26, Sumeet VERMA <sumeet.verma@st.com>:
> > Hi
> > Please find attached the esco patch for 2.6.18
> >
> > Sumeet
> >
> > -----Original Message-----
> > From: bluez-users-bounces@lists.sourceforge.net
> > [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of
> > Sent: Tuesday, March 25, 2008 11:41 AM
> > To: bluez-users@lists.sourceforge.net
> > Subject: [Bluez-users] How to enable eSCO in linux 2.6.18?
> >
> >
> > Hi All:
> >        I want to enable eSCO function in linux 2.6.18 for a certain
> > reason.... I know that 2.6.23 with the bluez-2.6.23mh1 patch can
> > enable simple eSCO support. But since i can't upgrade my kernel to
> > 2.6.23+ , is there any patches that can be applied on a 2.6.18 kernel
> > in order to make eSCO connections ?
> >
> >
> >
> > Thanks
> >
> >
> >
> >
> > semiyd
> >
> >
> >
> >
> >
> > _________________________________________________________________
> > News, entertainment and everything you care about at Live.com. Get it now!
> > http://www.live.com/getstarted.aspx
> >
> >
> > ----------------------------------------------------------------------
> > --- Check out the new SourceForge.net Marketplace.
> > It's the best place to buy or sell services for just about anything
> > Open Source.
> > http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marke
> > tplace _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> >
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for just about anything Open
> Source.
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
> -------------------------------------------------------------------------
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services for
> just about anything Open Source.
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_16113_10581925.1206515075405
Content-Type: image/jpeg; name=111.JPG
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fe9jwk1p
Content-Disposition: attachment; filename=111.JPG

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0a
HBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIy
MjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAJiAioDASIA
AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA
AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3
ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm
p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA
AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx
BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK
U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3
uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwDodW8N
Wnij4rrY3sk8ccegJKDCwByJMAZIPGGaiP4c6BJOIRNqKl8BN86jdu5B4iI9PSo9d12y8O/FH7Re
rdPFNoCW/wDowBfJkB7n0U8/Snt8RPDgiSOC21IxpvK74lYAtgFhhx23HBHUg9qVZ0rrm7Hfhlmb
hbCX5fKxg+K/h7ptvp2ki0vZ/NvdYhsDKzB1QOG527VJIwvc96o2fwqth4isLG8v7sQT3txZskts
LaaTy4mfzYgSweIkAbuOo4540vF3xC0qfStFTTrK53adq0N6UlVUVwoYkZBbBZmz04z7ViWfxRjs
NTiubTRX8ptUn1SaOW7DM8skTR7VIQbFG4nBDE+vr2Ybn5P3Wxw472yq/wC0/F5/8A5b/hEdczzY
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
CiiigAooooAKKKKAP//Z
------=_Part_16113_10581925.1206515075405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
------=_Part_16113_10581925.1206515075405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------=_Part_16113_10581925.1206515075405--
