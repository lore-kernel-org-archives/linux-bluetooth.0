Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Apple bluetooth mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: Elimar Riesebieter <riesebie@lxtec.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031230182456.GA3035@samweis.home.lxtec.de>
References: <20031228012502.GA16798@samweis.home.lxtec.de>
	 <20031228170349.GA1460@samweis.home.lxtec.de> <m3fzf47oa3.fsf@neo.loria>
	 <20031230182456.GA3035@samweis.home.lxtec.de>
Content-Type: text/plain
Message-Id: <1072813766.2542.28.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 30 Dec 2003 20:49:26 +0100

Hi Elimar,

> I try to get an Apple bt mouse to work with my 2.6.0 Debian system on
> powerpc G4 1Ghz laptop.
> 
> I`ve 
> download the deb sources,
> updated bluez-libs to 2.5 and bluez-utils to 2.4,
> and patched the kernel with
> http://www.holtmann.org/linux/kernel/patch-2.6.0-mh1.gz.
> 
> I didn't found a bluez module so I changed bluez to bluetooth in
> /etc/modutils/bluez.
> 
> After restarting the hid daemon there is no device hci0. create_dev
> fom Marcel Holtmann didn't help. Anyway the devices rfcomm* and vhci
> where still there. Following modules where loaded from the hid and
> sdp daemons:
> $ /sbin/lsmod | head -4
> Module                  Size  Used by
> rfcomm                 34200  0
> l2cap                  25028  5 rfcomm
> bluetooth              54912  6 rfcomm,l2cap
> 
> $ hcitool inq
> Inquiry failed.: No such device
> Inquiring ...
> 
> ls-pci -vv doesn't list me a something like bluetooth controller but
> unknown devices. Maybe the kernel does not recognize the responsible
> controller?
> 
> $ lspci | grep -i unknown
> 00:10.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4e50
> 01:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0035
> 01:17.0 Class ff00: Apple Computer Inc.: Unknown device 003e
> 01:18.0 USB Controller: Apple Computer Inc.: Unknown device 003f
> 01:19.0 USB Controller: Apple Computer Inc.: Unknown device 003f
> 01:1a.0 USB Controller: Apple Computer Inc.: Unknown device 003f
> 06:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0036
> 06:0d.0 Class ff00: Apple Computer Inc.: Unknown device 003b

send us "lspci -vvv" (as root) and the content of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
