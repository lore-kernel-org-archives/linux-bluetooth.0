Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Charles Bueche <charles@bueche.ch>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20031209224217.GE26896@smartdata.ch>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
	 <1070380907.19169.55.camel@saag> <1070482683.18058.6.camel@bluez.bueche.ch>
	 <1070483755.24159.114.camel@pegasus> <20031204085314.GA1780@smartdata.ch>
	 <1071001915.13464.33.camel@bluez.bueche.ch>
	 <20031209224217.GE26896@smartdata.ch>
Content-Type: text/plain
Message-Id: <1071043970.8979.5.camel@bluez.bueche.ch>
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
Date: Wed, 10 Dec 2003 09:12:50 +0100

Hi Olivier,

I tried your config, the wheel now works OK. Thanks a lot.

Another problem appeared after my initial email : the mouse movements
are showing sudden accelerations. Makes it difficult to use. I tried
several protocols in XF86Config-4, no difference.

I re-emerged Xfree without the patch, the problem persist.

I find this strange, as yesterday evening, the mouse suddenly worked
fine... I'm getting confused.

Could you provide your setup ? hciconfig command, loaded modules, bthid
command line, etc ?

Another question : do I need MOUSEDEV in my kernel ? I have 

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1920
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200

should I remove this ?

TIA,
Charles

On Tue, 2003-12-09 at 23:42, Olivier Bornet wrote:
> Hi Charles,
> 
> > 1. XFree patch
> > 
> > I patched my XFree (gentoo xfree-4.3.99.16) with this patch
> > (http://www.yhbt.net/normalperson/files/linux/LogitechMX_kernel_and_X_patch/4.3.0-XFree86_logitech_ps2.patch),
> > to make it understand PS/2+ protocol. Do I need this for the MX900 ?
> 
> I don't have applied this patch, so I think this is not needed. (but I
> don't know anything about this patch.
> 
> > 2. bthid patches
> > 
> > - started with the bthid 0.8 stock source
> > - applied Edd Dumbill's uinput patch
> > - applied Olivier Bornet's patch-bthid-0.6-for-lt.txt
> > - modified out.c to use /dev/misc/uinput (Marcel says devfs produce
> > this, I don't see exactly what I do wrong or what I should do to get
> > /dev/input/uinput).
> 
> OK. Almost the same for me, with a 2.6.0-test11 kernel.
> 
> > 3. XF86Config-4
> > 
> > --------
> > Section "InputDevice"
> >         Identifier              "LogitechUSBMouse"
> >         Driver                  "mouse"
> >         Option "Protocol"       "ExplorerPS/2"
> >         Option "Device"         "/dev/input/mice"
> >         Option "ZAxisMapping"   "7 8"
> >         Option "Resolution"     "800"
> >         Option "SmartScroll"    "1"
> >         Option "Buttons"        "8"
> >         Option "Emulate3Buttons" "false"
> > EndSection
> > ----------------
> 
> Usualy, the ZAxisMapping in on the buttons 4 and 5. Here is my
> XF86Config-4 related section:
> 
> ----------
> Section "InputDevice"
>         Identifier      "USB Mouse"
>         Driver          "mouse"
>         Option          "SendCoreEvents"        "true"
>         Option          "Device"                "/dev/input/mice"
>         Option          "Protocol"              "ImPS/2"
>         Option          "Buttons"               "5"
>         Option          "Emulate3Buttons"       "true"
>         Option          "ZAxisMapping"          "4 5"
> EndSection
> ----------
> 
> With this config, the mouse wheel is working ok.
> 
> Hope this help.
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
