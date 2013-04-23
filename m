Return-Path: <cyrus@holtmann.org>
Date: Tue, 23 Apr 2013 10:50:02 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Alex Deymo <deymo@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	keybuk@chromium.org
Subject: Re: [PATCH v2 1/8] core: Convert the pincode callback to an
 interable list.
Message-ID: <20130423075002.GA12102@x220>
References: <1365809318-17775-1-git-send-email-deymo@chromium.org>
 <1365809318-17775-2-git-send-email-deymo@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365809318-17775-2-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Fri, Apr 12, 2013, Alex Deymo wrote:
> The current pincode callback list on the adapter keeps track of all the
> pincode callbacks registered by a plugin for that adapter and calls each
> one until one provides a pincode for the current bonding. This mechanism
> forgets about what happened with previous bonding attempts and pushes the
> status track to the plugin side.
> 
> This patch creates an iterator struct (struct pincb_iter) that keeps track
> of the last function called and the number of times called. This will
> allow to provide more information about the bonding status to the pincode
> callback.
> ---
>  src/adapter.c | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
>  src/adapter.h |  4 ++++
>  src/device.c  | 13 +++++++++++++
>  src/device.h  |  1 +
>  4 files changed, 62 insertions(+), 8 deletions(-)

This patch doesn't pass basic coding style checks:

Applying: core: Convert the pincode callback to an interable list.
ERROR:OPEN_BRACE: open brace '{' following function declarations go on the next line
#24: FILE: src/adapter.c:4778:
+struct pincb_iter *pincb_iter_new(struct btd_adapter *adapter) {

ERROR:OPEN_BRACE: open brace '{' following function declarations go on the next line
#33: FILE: src/adapter.c:4787:
+void pincb_iter_free(struct pincb_iter *iter) {

ERROR:OPEN_BRACE: open brace '{' following function declarations go on the next line
#37: FILE: src/adapter.c:4791:
+gboolean pincb_iter_end(struct pincb_iter *iter) {

ERROR:OPEN_BRACE: open brace '{' following function declarations go on the next line
#144: FILE: src/device.c:3749:
+struct pincb_iter *device_bonding_iter(struct btd_device *device) {

Please fix those (and in other patches too if you have them). FWIW, I'm
using the following in my .git/hooks/pre-{applypatch,commit}:

git diff --cached | ~/src/linux/scripts/checkpatch.pl --no-signoff --ignore INITIALISED_STATIC,NEW_TYPEDEFS,VOLATILE,PARENTHESIS_ALIGNMENT --show-types --mailback -

The above assumes you've got a recent kernel source directory in ~/src/linux.

Johan
