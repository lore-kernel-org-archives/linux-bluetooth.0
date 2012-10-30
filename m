Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <508DCE10.40801@globaledgesoft.com>
References: <508D6672.8000009@globaledgesoft.com>
	<CAJdJm_MXB71MTcbrViLh486RtpWpx+a7SDvUPdSj2VdOa1fWvw@mail.gmail.com>
	<CAJdJm_NHaBzobi=k3cMaM-J_3d6R7FCEvfrSJWbkiKxKpjKHWA@mail.gmail.com>
	<508DCE10.40801@globaledgesoft.com>
Date: Tue, 30 Oct 2012 09:12:19 -0400
Message-ID: <CAJdJm_P=USyDO5op7_7ynOT8Qe7dOifyN=notezK1HGCxOe8bA@mail.gmail.com>
Subject: Re: BLE issue: Start_LE_Encryption fails
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay <ajay.kv@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Sun, Oct 28, 2012 at 8:30 PM, Ajay <ajay.kv@globaledgesoft.com> wrote:
> Thanks, but "sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 " ,   this
> command only sets the advertising data to zero right . so how do i set the
> adv flag as 0x06 . Which hci command is used for this  purpose .

No, this sets adv. data to have "Flags" AD set to 0x06. But you missed
the second line of the command:

sudo hcitool -i hci0 cmd 0x08 0x0008 03 02 01 06 \
    $(perl -e 'print "00 " x 28')

The second line is important because it fills the other bytes with
zero (which some controllers require).

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
