Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Frederic Dalleau <frederic.dalleau@access-company.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46B1573A.3080003@gmail.com>
References: <46AE7340.4010603@gmail.com>
	<1185870706.27218.43.camel@ubuntu.mpl.access-company.com>
	<1185871920.27218.44.camel@ubuntu.mpl.access-company.com>
	<46AF1AD8.2020703@gmail.com>
	<2d5a2c100707310929h1d8d48d3y5c26561c8d35cedd@mail.gmail.com>
	<46AF7DF4.8010701@gmail.com>
	<1185953899.21491.2.camel@ubuntu.mpl.access-company.com>
	<46B0801C.6070809@gmail.com>
	<2d5a2c100708012022kf3f53a0o7b227b9f51611f28@mail.gmail.com>
	<46B1573A.3080003@gmail.com>
Date: Thu, 02 Aug 2007 15:04:14 +0200
Message-Id: <1186059854.3574.2.camel@ubuntu.mpl.access-company.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] a2dp, sco and kernel version
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Can you please send me your kernel config file?
And if anybody have (or not) the same problem, they can too saying what 
they have.

Cheers,
Frederic

On Thu, 2007-08-02 at 01:02 -0300, Manuel Naranjo wrote:
> I want to help, just tell me what you need and I get it to all for you.
> I work for the company that builds the USB dongle [1], and I'm using the 
> hifi headset we sell. So I have plenty access to almost every hardware 
> detail. So please let me know what you need, logs, etc, and I get it.
> Thanks,
> Manuel
> 
> [1] http://www.aircable.net/host-xr.html
> 
> > Your bandwidth seems to be higher than expected,
> > thought we dont know how much is your bitpool.
> >
> > Here using 53 the bandwidth used is about 350 kbps,
> > using a value higher than 64 it starts to give me some
> > buffer problems.
> >
> > On 8/1/07, Manuel Naranjo <naranjo.manuel@gmail.com> wrote:
> >   
> >>> Make sure your stream is 44.1khz stereo
> >>>
> >>>       
> >> That's the first thing I had checked
> >>     
> >>> Do you use the plug plugin?
> >>>
> >>> pcm.!default {
> >>>         type plug
> >>>         slave.pcm "a2dpdplug"
> >>> }
> >>>
> >>> pcm.a2dpdplug {
> >>>         type a2dpd
> >>> }
> >>>
> >>> Also this variant may help :
> >>>
> >>> pcm.a2dpdplug {
> >>>         type a2dpd
> >>>       rateconstraint 44100
> >>> }
> >>>
> >>>       
> >> Sorry but that didn't worked.
> >>
> >> Here's what mplayer is telling me:
> >> alsa-play: trying to reset soundcard
> >> alsa-play: write error: Broken pipe0)  2.3%
> >> alsa-play: trying to reset soundcard
> >> A:  80.9 (01:20.9) of 189.0 (03:09.0)  2.3%
> >>
> >> And this is what a2dpd says about it:
> >> A2DPD[09:42:05.562]: display_daemon_state: [16,16|16,16] playing
> >> connected clients=1 freq=1032 cnt=24833 (1032/0) poll=1048
> >> latency=1185972125 sec.
> >> A2DPD[09:42:05.616]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:05.767]: a2dp_transfer_raw: Bandwith: 79488 (621 kbps) 32,
> >> latency=1185972125 sec.
> >> A2DPD[09:42:05.826]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:05.030]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:06.234]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:06.479]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:06.631]: display_daemon_state: [16,16|16,16] playing
> >> connected clients=1 freq=1144 cnt=25977 (1144/0) poll=1162
> >> latency=1185972126 sec.
> >> A2DPD[09:42:06.672]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:06.836]: a2dp_transfer_raw: Bandwith: 85077 (664 kbps) 32,
> >> latency=1185972126 sec.
> >> A2DPD[09:42:06.895]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:06.103]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:07.307]: a2dp_transfer_raw: send (retry).
> >> A2DPD[09:42:07.508]: a2dp_transfer_raw: send (retry).
> >>
> >> Any ideas what can be wrong?
> >>
> >> Thanks,
> >> Manuel
> >>
> >> -------------------------------------------------------------------------
> >> This SF.net email is sponsored by: Splunk Inc.
> >> Still grepping through log files to find problems?  Stop.
> >> Now Search log events and configuration files using AJAX and a browser.
> >> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> >> _______________________________________________
> >> Bluez-devel mailing list
> >> Bluez-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >>
> >>     
> >
> >
> >   
> 
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
