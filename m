Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f16b04cf0509290235264093c3@mail.gmail.com>
From: hariharan veerappan <hariharanneevee@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to avoid "hciconfig hci0 up"
In-Reply-To: <20050929092945.97395.qmail@web36102.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050929092945.97395.qmail@web36102.mail.mud.yahoo.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 29 Sep 2005 15:05:33 +0530

Hello,
Just add the Hci config command in the Boot script /etc/rc.local after
the Modprobe blutooth
has been completed.

Hariharan.V.

On 9/29/05, Swathi Mathur80 <swathi_mathur80@yahoo.com> wrote:
> Hello,
> Why do i need to always use the below command to get my bluetooth adpater
> working  when i restart my pc ?
>
>
> hciconfig hci0 up
> how can i avoid this ?
>
> Thanks in advance,
>
> Swathi
>
>  ________________________________
> Yahoo! for Good
>  Click here to donate to the Hurricane Katrina relief effort.
>
>


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
