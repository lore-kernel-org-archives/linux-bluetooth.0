Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Dec 2013 15:02:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/7] Add basic socket tests
Message-ID: <20131212130251.GA14427@x220.p-661hnu-f1>
References: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 12, 2013, Andrei Emeltchenko wrote:
> Initial socket test cases
> 
> Andrei Emeltchenko (7):
>   android/tester: Rename controller_setup to test_dummy
>   android/tester: Make generic_data structure const void pointer
>   android/tester: Add basic Socket Init test
>   android/tester: Add Socket data to generic test data struct
>   android/tester: Add Socket listen() invalid sock type
>   android/hal-sock: Fix returning unsupported instead of invalid
>   android/tester: Add Socket listen() invalid L2CAP socket type
> 
>  android/android-tester.c | 114 +++++++++++++++++++++++++++++++++++++++++------
>  android/hal-sock.c       |   2 +-
>  2 files changed, 102 insertions(+), 14 deletions(-)

All patches in this set have been applied. Thanks.

Johan
