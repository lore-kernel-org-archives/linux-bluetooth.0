Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Date: Fri, 20 Aug 2010 14:39:06 +0300
Message-ID: <AANLkTi=B=GoXrymjfKAnXuRDiTe7Uxqdiqs831nsWRb-@mail.gmail.com>
Subject: Re: [PATCH 0/8] Clean up Obex btio.[ch] and make it self contained
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Zhenhua Zhang <zhenhua.zhang@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 19, 2010 at 5:21 PM, Zhenhua Zhang <zhenhua.zhang@intel.com> wrote:
> Hi,
>
> This series of patches is to seperate btio.[ch] from src to btio directory. To make btio.[ch] self contained for obexd, there're some cleanup work:

Sounds good, this should make it easier to maintain those in sync with
other projects using it.

> 1. remove unused bt_io_set(). It is neither used by bluez or obexd.
> 2. remove unused SCO/L2RAW related code for Obexd. Note: BlueZ code requires SCO/L2RAW related functions. We may consider to add them back later.

Im not so sure if we want to have this code removed, obviously after
that in case of changes/fixes they may not apply cleanly in all
projects, so keeping them in sync won't be as easy anymore.

> 3. replace void *userdata with gpointer userdata. To make it consistent with bluez btio.c
> 4. refactor hci_devba into devid2ba. Remove dependence with hci*.h
> 5. Remove libbluetooth dependence for obexd.

This is fine as long as the other copies have this changes too.


-- 
Luiz Augusto von Dentz
Computer Engineer
