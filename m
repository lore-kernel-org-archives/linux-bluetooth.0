Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30803252300o387570b1s8b2ba96f01d7a462@mail.gmail.com>
Date: Wed, 26 Mar 2008 14:00:20 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <00e801c88ef7$1381d040$832fc70a@dlh.st.com>
MIME-Version: 1.0
References: <BAY117-W512E12E372AF6367AFF61C0FC0@phx.gbl>
	<00e801c88ef7$1381d040$832fc70a@dlh.st.com>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Sumeet VERMA:

   Thanks a lot!
   As a matter of fact , im using ST's bluetooth chip STLC2500. This
chip can't establish SCO connections under linux 2.6.18, so i had to
try eSCO connection.....that's why i want this esco patch.  i applied
your patch and eSCO seems to be connected. But still there's no sound
coming out of my bluetooth headset...
When i tried to disconnect the esco channel , hcid reports an
error..... Please refer to the details in this log:
(I use 'hstest' from bluez-utils to test the SCO/eSCO.)

 $ hstest play /tmp1/1.wav 00:0D:3C:EB:53:F0 1
Voice setting: 0x0060
hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)
RFCOMM channel connected
KERNEL:sco_connect(): type=2,eSCO

SCO audio channel connected (handle 8, mtu 60)
hcid[173]: link_key_request (sba=00:80:E1:00:AB:BA, dba=00:0D:3C:EB:53:F0)


/ $
/ $ hcid[173]: Disconnection failed: 0x0c

At the sametime , if i use another  USB bluetooth module instead of
STLC2500 , i can hear the music with my bluetooth headset after
established SCO connection.

Please, let me know if you have any other suggestions,thanks!!

semiyd


2008/3/26, Sumeet VERMA <sumeet.verma@st.com>:
> Hi
> Please find attached the esco patch for 2.6.18
>
> Sumeet
>
> -----Original Message-----
> From: bluez-users-bounces@lists.sourceforge.net
> [mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of
> Sent: Tuesday, March 25, 2008 11:41 AM
> To: bluez-users@lists.sourceforge.net
> Subject: [Bluez-users] How to enable eSCO in linux 2.6.18?
>
>
> Hi All:
>        I want to enable eSCO function in linux 2.6.18 for a certain
> reason.... I know that 2.6.23 with the bluez-2.6.23mh1 patch can enable
> simple eSCO support. But since i can't upgrade my kernel to 2.6.23+ , is
> there any patches that can be applied on a 2.6.18 kernel in order to make
> eSCO connections ?
>
>
>
> Thanks
>
>
>
>
> semiyd
>
>
>
>
>
> _________________________________________________________________
> News, entertainment and everything you care about at Live.com. Get it now!
> http://www.live.com/getstarted.aspx
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
>
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
