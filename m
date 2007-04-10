Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0704100437vb26836r20d1f4d5a198a489@mail.gmail.com>
Date: Tue, 10 Apr 2007 08:37:52 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2645.30405.qm@web54612.mail.yahoo.com>
MIME-Version: 1.0
References: <2645.30405.qm@web54612.mail.yahoo.com>
Subject: Re: [Bluez-devel] hci_rssi command
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

On 4/7/07, Carlos Araujo <karlos_barros@yahoo.com.br> wrote:
> I'm developing a location aplication using bluetooth, then I'll use the
> bluez, but I didn't find any documment description of its API. I'll use the
> power level of the received signal to perform this task. I've had headaches
> trying perform a hci_rssi command. Then I'd like a code example of using
> hci_rssi command or how to perform an inquiry with rssi. Could you help me.
>
>  thanks
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

Hi Carlos,

there are some D-Bus API docs available at:
http://wiki.bluez.org
http://wiki.bluez.org/wiki/Architecture
http://wiki.bluez.org/wiki/Adapter

you can use c, python, perl, c# or any language that supports D-Bus
bindings to start a device discover procedure. Check the python codes
utils/test/apitest and utils/dbusdef.py, there are some API usage
examples.

Run the dbus-monitor and check the output of the following line:
python -i dbusdef.py
>>>adapter.DiscoverDevices()

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
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
