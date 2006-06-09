Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4489519A.9080200@csr.com>
Date: Fri, 09 Jun 2006 11:46:50 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <e85851c20606080031q31dafb80qa7b144b81b997ca4@mail.gmail.com>
	<20060608231759.M13160@cos.ufrj.br>
In-Reply-To: <20060608231759.M13160@cos.ufrj.br>
Subject: Re: [Bluez-users] Min. output power of TPL
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

Alexandre Coser Monteiro wrote:
>       Anyone can explain to me, how its possible to read in Trasmit Power Level command
> by hcitool a valou of -20 dBm, if in power class definition of bluetooth its defined
> that the Minimum Output Power for Class 1 device is 0dBm !?! Is it my device broken ? 

0 dBm is the minimum maximum power.

That is a device must be able to reach at least 0 dBm to be able to call
itself class 1.

What you're reading is the current output power. Devices are allowed to
power control below 0 dBm if they don't need the extra power. This
reduces the interference on neighbouring networks.

There is an option in the HCI command to read the maximum transmit
power that will be used.

The relevant section of the spec is, in the BT 2.0 spec, volume 2,
part A, section 3, table 3.1 (particularly the footnotes) on page 31:

         Maximum
         Output           Nominal  Minimum
  Power  Power            Output   Output        Power
  Class  (Pmax)           Power    Power [1]     Control

      1  100 mW (20 dBm)  N/A      1 mW (0 dBm)  Pmin<+4 dBm to Pmax
                                                 Optional:
                                                 Pmin [2] to Pmax
  [...]

  [1] Minimum output power at maximum power setting.
  [2] The lower power limit Pmin<-30dBm is suggested but is not
      mandatory, and may be chosen according to application needs.

Note also, that class 1 devices must limit themselves to class 2
maximum power (+4 dBm) if the remote side does not support the
signalling required to control its peer's output power (same page
of the spec).

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php


_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
