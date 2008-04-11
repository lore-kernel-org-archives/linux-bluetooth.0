Return-Path: <cyrus@holtmann.org>
Message-ID: <194c6ea30804110126l560d9e5dj149ef955aca93e3c@mail.gmail.com>
Date: Fri, 11 Apr 2008 16:26:56 +0800
From: "dong yan" <semiydsemiyd@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <000901c88f0b$09c88e90$832fc70a@dlh.st.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Sumeet VERMA:

    I'm just writing this to tell you that your esco patch for 2.6.18
works well.I modified some settings within the sff file , use "hstest"
to establish an esco connection and then send the audio data directly
into pcm interface connected to stlc2500. Now i can play/record music
on esco.
    Thanks for the patch!

Best Regards

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

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
