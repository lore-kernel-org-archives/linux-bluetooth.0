Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <002801c771c7$3e9f3400$9d0cc70a@dlh.st.com>
References: <002801c771c7$3e9f3400$9d0cc70a@dlh.st.com>
Date: Sat, 31 Mar 2007 15:56:59 +0200
Message-Id: <1175349419.5815.274.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] hcid returning "Device or resource busy"?
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

Hi Mayank,

> > > I hope there's at least some way to get it working. I'd 
> > > rather not have
> > > to have another dongle just because hcid doesn't like it :)
> > 
> > the problem is that the baseband is busy with the remote name request.
> > It has to page the remote device for getting the name and in that case
> > you simply can't run an inquiry. All currently available 
> > Bluetooth chips have this limitation.
> > 
> > Main question is why we have the remote name request just before you
> > wanna start the inquiry. What D-Bus methods are you actually calling
> in
> > what order? I think you constructed a use case that we never tested.
> 
> But actually, the sequence of HCI commands issued is correct. First, a
> remote
> name request is issued. Then, since an inquiry is required, the remote
> name
> request is cancelled. Thus, paging should stop and inquiry should be
> possible.
> I think this use case should work with BT1.2 devices and above.
> 
> But you are right, maybe some workaround should be present in order to
> be
> compatible with BT1.1 devices as well.

we need a workaround for Bluetooth 1.1 devices. However I have no idea
what we can actually do to make this work.

My idea is to not actively request names when not in discovery mode.
That would actually fix this cases.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
