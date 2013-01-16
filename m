Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Jan 2013 14:36:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] unit: Add {TEXT,URL}_STR{8,16} tests for
 sdp_extract_attr()
Message-ID: <20130116123607.GA12158@x220>
References: <1357867322-31384-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357867322-31384-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Thu, Jan 10, 2013, Anderson Lizardo wrote:
> These tests are for valid data. Other tests might be added later to
> check for error paths, but will require separate macros.
> 
> {TEXT,URL}_STR32 cannot be tested with the same macros because
> sdp_extract_attr() does not support them. They will be tested
> separately with other SDP library functions.
> 
> As example of failure output, if commit
> 504a0cf46ad89cab8005ce9cffb22e41048f6a30 is reverted for testing, the
> STR16 test will fail with:
> 
> ERROR:unit/test-sdp.c:776:test_sdp_de_attr: assertion failed
> (test->input_size == size): (7 == 11)
> ---
>  unit/test-sdp.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)

Both patches have been applied. Thanks.

Johan
