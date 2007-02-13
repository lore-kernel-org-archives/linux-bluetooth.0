Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <9da483cb0702130106s3c76315g2c57fd4f1017ad23@mail.gmail.com>
Date: Tue, 13 Feb 2007 02:06:10 -0700
From: "Mike Hodson" <mystica@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <45D138AF.3040708@xmission.com>
MIME-Version: 1.0
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
	<45D138AF.3040708@xmission.com>
Subject: Re: [Bluez-devel] Successes and failures with btsco/bluez
	respectively
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

On 2/13/07, Brad Midgley <bmidgley@xmission.com> wrote:
> Mike
> hmm. maybe you should also try the a2dp plugin from btsco-0.5. that was
> before some pretty massive changes. We should have been tagging plugz
> but I haven't known when to tag it.
Ok, I did see that in there, but I was not sure if it was "usable" as
the ./configure/make did not  build it.

> I'm not sure on hcidump logs, but one thing that causes similar problems
> with my spider set is having my cellphone on. The spider is connected to
> both the computer and the cellphone, so it wants to be the master
> device. The computer also typically wants to be master and if you have a
> smartphone it will too. The result is a big scatternet (possibly with
> roles switching around) and extremely poor quality of delivery.

I have specifically tried this with my phone turned off, as I read
that this could cause issues as well. Literally, with no configuration
changes, no phone changes, no headset powering on/off, basically
nothing changed except a2dpd vs a2dpd2 it starts going from pausing
every few seconds to completely disconnecting.  Also, in my bluez
configuration I have explicitly denied role-switching:

 lm accept,master;
 lp hold,sniff,park;

> it's possible we somehow have the outbound and inbound avrcp connections
> going simultaneously. also, in early avrcp testing I remember seeing
> doubled-up messages from some sets that were subtly different and I
> thought I had added code to throw out the fake message.

Noted.  I shall wait for progress on this.

I have tested older a2dpd and pcm.a2dpd plugins from btsco-0.5, works
flawlessly from what I can tell.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
