Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300805010703x5ec18761xd2f80bf2b31fab1f@mail.gmail.com>
Date: Thu, 1 May 2008 08:03:06 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <46f855150805010641q1e164d86h46d2bc8352d6ed37@mail.gmail.com>
MIME-Version: 1.0
References: <48171A58.8060200@powercraft.nl> <4817DAE3.6050406@gmail.com>
	<d89ddf300804291959m6589b95fse31e8227c37c8f1f@mail.gmail.com>
	<4818E1B3.6000900@powercraft.nl>
	<46f855150805010641q1e164d86h46d2bc8352d6ed37@mail.gmail.com>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
	headset fully working with the bluez software stack under linux
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

Chris

> To add my experiences, audio only drops out when using other bluetooth
> devices connected to the same computer. That is, I can use bluetooth in the
> vicinity without interference, so it doesn't seem to be an over-the-air
> thing. Also, I see the problem with my bt keyboard: even pressing a single
> key can cause a drop while moving the mouse normally takes a couple of
> seconds to mess up the audio. I suspect this has something to do with
> changing connection state, but I don't actually know.

does "sudo hcitool con" also show your adapter as master on all the
connections? It's often been a scatternet (the computer's bt adapter
switching from one piconet to another) that causes the problem.

> Also, the problem is far, far worse with high quality music than, say, a
> poor quality book on tape. I almost never have a problem listening to voice
> but always when listening to symphonic music. Perhaps it's compressibility?

I would think so. A smaller bandwidth stream has less demand for
continuous data flow.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
