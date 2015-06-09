Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Jun 2015 10:43:54 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC untested] Bluetooth: btusb: Fix secure send command length
 alignment on Intel 8260
Message-ID: <20150609074354.GA30226@t440s.lan>
References: <1433663228-30253-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433663228-30253-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Sun, Jun 07, 2015, Marcel Holtmann wrote:
> This patch fixes the command length alignment issue for Intel Bluetooth
> 8260.
> 
> The length of parameters in the firmware downloading command must be
> multiplication of 4. If not, the command must append Intel_NOP command
> with extra parameters, zeros, at the end, and the firmware file is
> already included Intel_NOP command for alignment.
> 
> This patch checks the next command and if the next command is Intel_NOP
> command, it reads the Intel_NOP command and send them together.
> 
> For example, if the data from the firmware file looks like this:
> 8E FC 03 11 22 33 02 FC 03 00 00 00
> 
> Previously, btusb sends two commands:
> 09 FC 06 8E FC 03 11 22 33
> 09 FC 06 02 FC 03 00 00 00
> 
> This won't work because the length of parameters are 6 which violates
> the 4 byte alignment.
> 
> This patch will append them together and send as one command:
> 09 FC 0C 8E FC 03 11 22 33 02 FC 03 00 00 00
> 
> Based on previous work from Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> Reported-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
