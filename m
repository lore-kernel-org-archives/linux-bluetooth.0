Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300712022226q7bccbe7fl461d94e2eae8b33c@mail.gmail.com>
Date: Sun, 2 Dec 2007 23:26:33 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <82b2af8e0712020835s12e9ac05m7475b78dfafea96c@mail.gmail.com>
MIME-Version: 1.0
References: <82b2af8e0712020835s12e9ac05m7475b78dfafea96c@mail.gmail.com>
Subject: Re: [Bluez-users] My blueetooth is supported?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

you may need to activate the adapter using toshset first

sudo apt-get install toshset
sudo toshset -bluetooth on

On Dec 2, 2007 9:35 AM, =C1ngel Guzm=E1n Maeso <shakaran@gmail.com> wrote:
> I have Ubuntu 7.10, but my bluetooth doesn't work.
>
> The commands:
>
> shakaran@shakaran:~$ dmesg | grep Blue
> [   38.044000] Bluetooth: Core ver 2.11
> [   38.044000] Bluetooth: HCI device and connection manager initialized
> [   38.044000] Bluetooth: HCI socket layer initialized
> [   38.084000] Bluetooth: L2CAP ver 2.8
> [   38.084000] Bluetooth: L2CAP socket layer initialized
> [   38.488000] Bluetooth: RFCOMM socket layer initialized
> [   38.488000] Bluetooth: RFCOMM TTY layer initialized
> [   38.488000] Bluetooth: RFCOMM ver 1.8
> [   38.696000] Bluetooth: BNEP (Ethernet Emulation) ver 1.2
> [   38.696000] Bluetooth: BNEP filters: protocol multicast
>
> shakaran@shakaran:~$ sudo hidd --search
> Searching ...
> shakaran@shakaran:~$  sudo hciconfig hci0 inqmode 0
> Can't get device info: No such device
> shakaran@shakaran:~$ hciconfig
>
> I have a laptop Toshiba Satellite M60-126
>
> In Windows XP bluetooth works but not because ubuntu gutsy?
>
> Thanks you
>
> --
> Shakaran
> Administrador de Apogeus - www.apogeusone.com
> Tu web hispana del juegos de Rol  Apogeus, ONLINE y GRATUITO
> -------------------------------------------------------------------------
> SF.Net email is sponsored by: The Future of Linux Business White Paper
> from Novell.  From the desktop to the data center, Linux is going
> mainstream.  Let it simplify your IT future.
> http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>



-- =

Brad

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
