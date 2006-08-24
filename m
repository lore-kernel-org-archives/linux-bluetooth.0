Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d23110170608241129w5db6bffdq5c616f98ad74e509@mail.gmail.com>
Date: Thu, 24 Aug 2006 15:29:04 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060824150926.GQ8944@null.research.nokia.com>
MIME-Version: 1.0
References: <20060824150926.GQ8944@null.research.nokia.com>
Subject: Re: [Bluez-devel] [PATCH] rfcomm_dev_del is called twice if
	RFCOMM_HANGUP_NOW flag is used
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ville,

On 8/24/06, Ville Tervo <ville.tervo@nokia.com> wrote:
> I noticed that rfcomm_dev_del() may be called twice if
> RFCOMM_HANGUP_NOW flags is used with RFCOMMRELEASEDEV ioctl.

I think you're right but we must have the RFCOMM_RELEASE_ONHUP bit set
on dev->flags also, right?

> I made a patch that checks if dev is still in the device list before
> calling deleting device.
> The checking is done now in rfcomm_release_dev. Maybe better place would
> be rfcomm_dev_del?

Actually calling list_del_init() on an item thas was already deleted
with list_del_init() won't hurt anyone but it seems we can mess up the
reference counting by calling rfcomm_dev_del() twice.

I think your patch doesn't completely solve the problem because
rfcomm_dev_get() will hold a reference to the device if we still
manage to find it on the list and we will have reference counting
problems too. Adding a call to rfcomm_dev_put() before the call to
rfcomm_dev_del() in your patch will keep the reference counting
correct, I guess. Something like this:

  if ((dev = rfcomm_dev_get(req.dev_id))) {
		rfcomm_dev_put(dev);
		rfcomm_dev_del(dev);
  }

What do you think, Marcel?

Best regards,

-- Ulisses

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
