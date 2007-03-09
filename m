Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0703090617n2954fbbbv2ce2d75dfc0e9036@mail.gmail.com>
Date: Fri, 9 Mar 2007 11:17:37 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <be976db60703081101p78084e24g2bd5f076fcee82a2@mail.gmail.com>
MIME-Version: 1.0
References: <be976db60703081101p78084e24g2bd5f076fcee82a2@mail.gmail.com>
Subject: Re: [Bluez-users] DBUS and Bluez
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

On 3/8/07, Mark S. Townsley <mstownsley@gmail.com> wrote:
> Hi:
>
> I read that Bluez hcid requires DBUS to be up and running to function
> properly.  Is that correct?
>
> I would like to also play with the Bluez DBUS API.  I found  the API guide
> but would like to know if there is anything special
> config entries I need to make inside the DBUS config file.  Can someone
> point me to the proper DBUS config  file for Bluez to
> function properly?
>
> thanks.
>
>
> Mark
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
Hi Mark,

Just check if the file utils/daemon/bluetooth.conf is in the following
directory: /etc/dbus-1/system.d/

BR,
Claudio.

-- 
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
