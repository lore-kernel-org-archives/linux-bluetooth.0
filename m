Return-Path: <cyrus@holtmann.org>
Message-ID: <52CE6321.1010909@timomueller.eu>
Date: Thu, 09 Jan 2014 09:51:45 +0100
From: =?ISO-8859-1?Q?Timo_M=FCller?= <mail@timomueller.eu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [RFCv4 0/5] SSP MITM protection
References: <cover.1387450435.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1387450435.git.timo.mueller@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Timo Mueller wrote, On 19.12.2013 14:08:
> From: Timo Mueller <timo.mueller@bmw-carit.de>
> 
> Hi,
> 
> this is a rebased version of the rfc v3. I've successfully tested
> these changes in the last couple of months at the UPF #46 in Vienna,
> with the CE4A golden device and the bluetooth PTS (where applicable).
> 
> At the UPF I've tested remotely initiated pairing with different io
> capabilities, as well locally initiated pairing. Regardless of the
> bonding mode, the protocol chosen in ssp has been consistent when
> being responder and also when being initiator. Pairing tests have been
> successful in all 22 test sessions.
> 
> The configuration I used for testing was as follows:
> bluez: 5.9-154-gf7773c7
> kernel: v3.12-rc3-65-gf927318
> with the remaining patches from [RFC BlueZ v3 0/8] SSP MITM protection
> 
> I used the same configuration to test the patches with the CE4A golden
> device. Pairing here has been working as expected with all
> combinations of io capabilities, bonding mode and intiator role.
> 
> Lastly I've successfully ran the applicable GAP tests with the
> bluetooth PTS on this rebased version and the current head of
> bluez. Unfortunately the interesting bonding test cases are not yet
> implemented with the test suite. So I could only make sure general
> functionality is preserved.
> 
> from the original cover letter:
> The way the kernel handles MITM Protection during pairing is
> inconsistent: General Bonding and Dedicated Bonding are not treated
> equally.
> <snip>
> Therefore, the safest choice is to always request MITM Protection,
> also for General Bonding [1]. The proposal here is to do this for both
> incoming (patch 6/8) and outgoing (patch 7/8) procedures, as it was
> previously done for Dedicated Bonding. This "conservative" approach is
> smart enough to fall back to not using MITM Protection if the IO
> capabilities don't allow it (this policy already existed before for
> Dedicated Bonding, see patch 5/8).
> <snip>
> 
> Best regards
> Timo
> 
> Mikel Astiz (3):
>   Bluetooth: Refactor hci_get_auth_req()
>   Bluetooth: Refactor code for outgoing dedicated bonding
>   Bluetooth: Request MITM Protection when initiator
> 
> Timo Mueller (2):
>   Bluetooth: Use MITM Protection when IO caps allow it
>   Bluetooth: Add management command to relax MITM Protection
> 
>  include/net/bluetooth/hci.h  |  3 ++-
>  include/net/bluetooth/mgmt.h |  3 +++
>  net/bluetooth/hci_event.c    | 57 ++++++++++++++++++++++++++++----------------
>  net/bluetooth/mgmt.c         | 50 ++++++++++++++++++++++++++++++++++----
>  4 files changed, 87 insertions(+), 26 deletions(-)
> 

Ping
