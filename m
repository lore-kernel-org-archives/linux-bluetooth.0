Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d23110170609121255w494a0e9fud62f839498989c98@mail.gmail.com>
Date: Tue, 12 Sep 2006 16:55:13 -0300
From: "Ulisses Furquim" <ulissesf@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <4504D825.2020109@xmission.com>
MIME-Version: 1.0
References: <200609101824.25866.Linux@feline-soul.com>
	<4504D825.2020109@xmission.com>
Subject: Re: [Bluez-users] bluetooth headset: Fuction not Implemented?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

On 9/11/06, Brad Midgley <bmidgley@xmission.com> wrote:
> if you can't run
>
> sdptool browse 00:0D:44:4F:37:72
>
> and get a list of services then you have a problem that is more
> fundamental than just audio. (that is equivalent to what btsco is trying
> to do when it prints the sdp error.)

Hmm.. maybe this headset doesn't implement the kind of search sdptool
and btsco are doing (service search attribute request)? Marcel said
there were some devices that implement only service search and service
attribute SDP requests. Is that correct, Marcel?

Regards,

-- Ulisses

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
