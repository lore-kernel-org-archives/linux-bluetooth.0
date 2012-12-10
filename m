Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50C3F088.2090203@globaledgesoft.com>
References: <508D6672.8000009@globaledgesoft.com>
	<CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com>
	<CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
	<508DCE10.40801@globaledgesoft.com>
	<CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com>
	<508DDCE7.6030708@globaledgesoft.com>
	<CAJdJm_PLSAZBc+ef_YXsmQ+VE5aW3aD_CPs3x2Y7gY+8zY19Bw@mail.gmail.com>
	<50BE45BB.409@globaledgesoft.com>
	<CAJdJm_Miiidw08Tk2-6mtoDFQ0uhyez=H+NKRK-2UYjyTQ9d1A@mail.gmail.com>
	<50C3F088.2090203@globaledgesoft.com>
Date: Mon, 10 Dec 2012 11:18:16 -0400
Message-ID: <CAJdJm_P1hjsh2UXYcmbNHD71idPHvgDj+WpLOnSkvkQ+FZYAMg@mail.gmail.com>
Subject: Re: BLE issue: Start_LE_Encryption fails
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Dec 8, 2012 at 9:59 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
>     I tried  "gatttool  -i hci0 -b <remote bdaddr> --primary " on master
> side  ,which creates   LE link and very next moment disconnects . How can i
> change the security level  of the link to medium?. still struggling to pair
> the device  (atleast "smp just works") ) . Is my kernel supportive (3.2.5)

You can try using the --sec-level medium option.

>         Every time on LE create connection  process     i
> ,smp_conn_security() getting called from hci layer .
>   But  if(host_le_capable(hcon->hdev))
>                 return 1;
> condition returns without even checking the security level . so kindly show
> me the right way..

I suspect this check has been added recently to the kernel. Try
running bluetoothd oh the master side as well, it should then enable
host LE support through mgmt API and this check should pass.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
