Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 23:06:43 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Testcases to verify HCI_LE_ENABLE fix in kernel
Message-ID: <20150212210643.GB14557@t440s.P-661HNU-F1>
References: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423654332-32424-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Wed, Feb 11, 2015, Lukasz Rymanowski wrote:
> Following patches should get in if kernel fix for HCI_LE_ENABLE
> gets upstream
> [PATCH v2 1/3] Bluetooth: Do not allow LE connection if LE is not
>  enabled
> 
> Here we have 2 test cases on mgmt and l2cap level verifying that
> LE connection will be rejected if LE host support is not enabled.
> 
> Also small update to error codes in mgmt-api has been added as now
> Pair Device might return MGMT_RESULT_REJECT if user tries to make
> connection on transport which is not enabled
> 
> v2:
> * added new test cases for v2 of kernel patch.
> * Added "Not Supported" error code to mgmt-api.txt
> * Update test-coverage.txt 
> 
> Lukasz Rymanowski (4):
>   tools/mgmt-tester: Add test for pair on not enabled transport
>   tools/mgmt-tester: Add test for pair on not supported transport
>   tools/l2cap-tester: Add L2CAP LE Connection Reject test
>   doc/mgmt-api: Update error codes for Pair Device Command
> 
>  doc/mgmt-api.txt     |  9 ++++++-
>  tools/l2cap-tester.c | 45 +++++++++++++++++++++++++++++++--
>  tools/mgmt-tester.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 120 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan
