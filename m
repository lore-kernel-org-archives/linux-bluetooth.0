Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Jul 2014 11:44:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 00/11] Rest of the android bluetooth core tests
Message-ID: <20140721084450.GB24049@t440s.lan>
References: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Jul 21, 2014, Jakub Tyszkowski wrote:
> Those are the last few test cases left for core bluetooth profile.
> 
> v2 is just a rebased v1.
> 
> Jakub Tyszkowski (11):
>   android/tester-ng: Allow test framework user to choose emu type
>   android/tester-ng: Improve result print
>   android/tester-ng: Improve callback defining makro
>   android/tester-ng: Improve variable's names
>   android/tester-ng: Add missing check for callback status
>   android/tester-ng: Add pin request and bond state callbacks
>   android/tester-ng: Add BREDR pairing with pin test case
>   android/tester-ng: Add wrong PIN reply test case
>   android/tester-ng: Add ssp confirmation cases
>   android/tester-ng: Add more bonding cases
>   android/tester: Remove old bluetooth core test cases
> 
>  android/android-tester.c   | 282 ------------------------
>  android/tester-bluetooth.c | 521 +++++++++++++++++++++++++++++++++------------
>  android/tester-gatt.c      |   2 +-
>  android/tester-hidhost.c   |   2 +-
>  android/tester-main.c      | 263 +++++++++++++++++++++--
>  android/tester-main.h      |  58 ++++-
>  android/tester-socket.c    |   2 +-
>  7 files changed, 677 insertions(+), 453 deletions(-)

All patches in this set have been applied. Thanks.

Johan
