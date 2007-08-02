Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300708021212y757401fdqc9f98a040911fa1e@mail.gmail.com>
Date: Thu, 2 Aug 2007 13:12:44 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46B22843.909@gmail.com>
MIME-Version: 1.0
References: <46AE7340.4010603@gmail.com> <46AF7DF4.8010701@gmail.com>
	<1185953899.21491.2.camel@ubuntu.mpl.access-company.com>
	<46B0801C.6070809@gmail.com>
	<2d5a2c100708012022kf3f53a0o7b227b9f51611f28@mail.gmail.com>
	<46B1573A.3080003@gmail.com>
	<1186059854.3574.2.camel@ubuntu.mpl.access-company.com>
	<1186059924.3574.4.camel@ubuntu.mpl.access-company.com>
	<46B1F5B9.6070107@gmail.com> <46B22843.909@gmail.com>
Subject: Re: [Bluez-devel] a2dp, sco and kernel version [Possible Solution]
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

Manuel

On 8/2/07, Manuel Naranjo <naranjo.manuel@gmail.com> wrote:
> I finally could narrow the problem CONFIG_HIGH_RES_TIMERS is the one
> that makes a2dpd fail in certain circumstances. I'm not sure if my
> hardware has support for this feature or not, but anyway it's good to
> know what's causing the problem.
> So to all those of you that have a kernel >= 2.6.21 and can't use a2dpd
> can disable CONFIG_HIGH_RES_TIMERS, recompile and reinstall your
> kernels, and should get a2dpd working again.

the use of highres timers is chosen dynamically at boot based on the
hardware capabilities. There should be a boot parameter to disable it.
That would be helpful for our troubleshooting documentation.

didn't someone say things worked in 2.6.23-rc1 or was that test done
without high-res timers enabled?

brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
