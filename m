Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <d23110170608111309q263bc87fyf6474dce4d0e535e@mail.gmail.com>
References: <44D88EC1.7010009@pracucci.com> <44D8815D.4000108@infitsrl.com>
	<d23110170608090806j2b39e87eqd84ba9843d216153@mail.gmail.com>
	<1155236923.4492.49.camel@aeonflux.holtmann.net>
	<d23110170608111203g590369d4qdc4592c284eafa55@mail.gmail.com>
	<1155333717.4518.14.camel@aeonflux.holtmann.net>
	<d23110170608111309q263bc87fyf6474dce4d0e535e@mail.gmail.com>
Message-Id: <15FB7B62-A264-458C-8960-BE999D3D1A29@infitsrl.com>
From: Fabrizio Guglielmino <guglielmino@infitsrl.com>
Date: Wed, 16 Aug 2006 22:21:18 +0200
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] "File descriptor in bad state" on sdp_connect()
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

Hi Ulisses,
I have been outside for a few days...and now I'm reading all the mail  
about sdp_connect problem.
if I find the time I install the patch on a development system so I  
try to contribute to the final version.

bye


Il giorno 11/ago/06, alle ore 22:09, Ulisses Furquim ha scritto:

> On 8/11/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>> look into l2cap_conn_del() and check what happens if l2cap_data is  
>> NULL.
>> This doesn't change the behavior.
>
> Doooh. Right. We shouldn't be calling l2cap_conn_del() at all if
> l2cap_data is NULL so it doesn't change any behavior and we actually
> save one function call. :-)
>
> Regards,
>
> -- Ulisses
>
> ---------------------------------------------------------------------- 
> ---
> Using Tomcat but need to do more? Need to support web services,  
> security?
> Get stuff done quickly with pre-integrated technology to make your  
> job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache  
> Geronimo
> http://sel.as-us.falkag.net/sel? 
> cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
