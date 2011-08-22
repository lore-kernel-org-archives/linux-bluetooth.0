Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Aug 2011 11:04:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH hcidump] Fix L2CAP cid matching
Message-ID: <20110822080407.GA11306@dell>
References: <1313254386.2254.8.camel@THOR>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313254386.2254.8.camel@THOR>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Sat, Aug 13, 2011, Peter Hurley wrote:
> If multiple ACL connections are using identical cid values, the L2CAP
> parser will match the first avail cid found in the cid table. This
> error often leads to incorrect psm determination, and thus incorrect
> parsing of higher-layer frames.
> 
> When searching the cid table, a matching cid value must match by
> ACL handle as well.
> ---
>  parser/l2cap.c |   42 +++++++++++++++++++++++-------------------
>  1 files changed, 23 insertions(+), 19 deletions(-)

Applied, but again I got this because of an unclean patch:

/home/jh/src/bluez-hcidump/.git/rebase-apply/patch:14: trailing whitespace.
static uint16_t get_psm(int in, uint16_t handle, uint16_t cid)
/home/jh/src/bluez-hcidump/.git/rebase-apply/patch:21: trailing whitespace.
		if (table[i].handle == handle && table[i].cid == cid)
/home/jh/src/bluez-hcidump/.git/rebase-apply/patch:27: trailing whitespace.
static uint16_t get_num(int in, uint16_t handle, uint16_t cid)
/home/jh/src/bluez-hcidump/.git/rebase-apply/patch:34: trailing whitespace.
		if (table[i].handle == handle && table[i].cid == cid)
/home/jh/src/bluez-hcidump/.git/rebase-apply/patch:40: trailing whitespace.
static void set_mode(int in, uint16_t handle, uint16_t cid, uint8_t mode)
warning: squelched 18 whitespace errors
warning: 23 lines add whitespace errors.

Johan
