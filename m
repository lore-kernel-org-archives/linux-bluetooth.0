Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031210083002.GG26896@smartdata.ch>
References: <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
	 <1071043970.8979.5.camel@bluez.bueche.ch>
	 <20031210083002.GG26896@smartdata.ch>
Content-Type: text/plain
Message-Id: <1071330995.4307.27.camel@bluez.bueche.ch>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 13 Dec 2003 16:56:35 +0100

Hi Olivier,

Thanks for your answer. I don't run GPM, so the problem isn't from
there. But you gave me another idea : I loaded my modules, started the
patched bthid, exited X, and tried gpm in console. I got the same
problem !!! The mouse is jumpy as well. I think I can now exclude Xfree
from the potential problem.

I guess bthid is producing the jumpy mouse. I tried to checkout the CVS
version, but I'm lost with autoconf and friends. I guess I will have to
wait for Marcel's new snapshot.

What frustrate me is that I got it working twice last week, after
unloading/loading stopping/starting it several times, but I lost the
order and options I had.

Well, we it works, we all have to get a good beer :-)

Charles

On Wed, 2003-12-10 at 09:30, Olivier Bornet wrote:
> Hi Charles,
> 
> > I tried your config, the wheel now works OK. Thanks a lot.
> 
> Great. :-)
> 
> > Another problem appeared after my initial email : the mouse movements
> > are showing sudden accelerations. Makes it difficult to use. I tried
> > several protocols in XF86Config-4, no difference.
> 
> I have add this kind of problem with my USB mouse long time ago. This
> was because I have also gpm working (mouse usage in non grphical
> session). I you need to use gpm at the same time of XFree, you need to
> search on the web, as there is some special config to do. A quick search
> on google give lot of tips for this config. For example
> http://linuxfromscratch.org/pipermail/blfs-dev/2003-April/002637.html
> 
> > I find this strange, as yesterday evening, the mouse suddenly worked
> > fine... I'm getting confused.
> 
> Maybe you have installed gpm ?
> 
> > Could you provide your setup ? hciconfig command, loaded modules, bthid
> > command line, etc ?
> 
> I think as you have it working (maybe bad, but working), your bluetooth
> config is OK (hciconfig command, loaded modules). For the bthid command
> line, I have modified the /etc/init.d/bluetooth-hid file for having the
> command line:
> 
> 	bthid -m -l -s
> 
> > Another question : do I need MOUSEDEV in my kernel ? I have 
> > 
> > CONFIG_INPUT_MOUSEDEV=y
> > CONFIG_INPUT_MOUSEDEV_PSAUX=y
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1920
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
> 
> I think you need CONFIG_INPUT_MOUSEDEV, but I'm not sure. I have it in
> module. (but as I also have a USB mouse, I really need it).
> 
> > should I remove this ?
> 
> Because XF86Config-4 use /dev/input/mice, I think you really need it.
> 
> Good day.
> 
> 		Olivier
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
