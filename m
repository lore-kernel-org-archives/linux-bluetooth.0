Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50BE45BB.409@globaledgesoft.com>
References: <508D6672.8000009@globaledgesoft.com>
	<CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com>
	<CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
	<508DCE10.40801@globaledgesoft.com>
	<CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com>
	<508DDCE7.6030708@globaledgesoft.com>
	<CAJdJm_PLSAZBc+ef_YXsmQ+VE5aW3aD_CPs3x2Y7gY+8zY19Bw@mail.gmail.com>
	<50BE45BB.409@globaledgesoft.com>
Date: Thu, 6 Dec 2012 06:50:53 -0400
Message-ID: <CAJdJm_Miiidw08Tk2-6mtoDFQ0uhyez=H+NKRK-2UYjyTQ9d1A@mail.gmail.com>
Subject: Re: BLE issue: Start_LE_Encryption fails
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Tue, Dec 4, 2012 at 2:49 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
> SLAVE side
>
> root@test:/home#  hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
>
>                         $(perl -e 'print "00 " x 28')
> root@test:/home# hciconfig hci0  leadv
>
>
> Hcidump shows ..
>
> < HCI Command: LE Set Advertising Data (0x08|0x0008) plen 32
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Set Advertising Data (0x08|0x0008) ncmd 1
>     status 0x00
> < HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Set Advertise Enable (0x08|0x000a) ncmd 1
>     status 0x00
>
>> HCI Event: LE Meta Event (0x3e) plen 19
>     LE Connection Complete
>       status 0x00 handle 64, role slave
>       bdaddr 00:02:72:D6:AB:AD (Public)
>> ACL data: handle 64 flags 0x02 dlen 11
>     ATT: Read By Group req (0x10)
>       start 0x0001, end 0xffff
>       type-uuid 0x2800

Your slave device is not answering to the Read By Group request,
therefore the master side is disconnecting due to timeout.

I suggest you first try using gatttool on the master side to connect
to the slave, and run "primary" to see if it is processing GATT
requests.

The bluez log from the slave side should help (I assume you are
running BlueZ on the slave side).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
