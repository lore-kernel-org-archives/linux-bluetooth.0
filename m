Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D8038239D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 19:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341814; cv=none; b=E2e1qnVy1Nzw0btcrqCLKPflRfBWSRNfGOdjjQI6PipOVbo69x1VJbdtee7g+2PvqsgndfywUBCrf3arosWGeTEyrfJS1otoHfMuY2amjHiSL3tLs5JOxwRgSqbG+P/JKPI+y8k4OKW8OgBjahQhejtabl469qnms4dCimRNSRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341814; c=relaxed/simple;
	bh=ht5niu6vfH2p6S6Ba0++7kumIjPPx9VWK8Yw0ZWMIrg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jYE5cuS71ADI+dx62QMc3n2wAdPCxyW4JvbjUgDBGZJL26GyVdV7sOqECiqBA1a2eOtc01vUKIvn0xUZsuhBIaJPWUR9n1ju3Vpne3ubJBxzA4HEKf2IxPR7KI6xBijeX5gfTr0Q/UNcvV8+ILEOCxHuQPnq56I6xwvXYLigtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QV7Ql3Yc; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QV7Ql3Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787341808;
	bh=6/oI1/Ur031snQFT+f8jkMRb48TCAXsqL1Uv+5UjGWM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QV7Ql3YcNOarVw9zs5drEwutautz+4TEI9X0eLdmQUfNm8KDimjjTXcY+Bx+EPMJn
	 5VmfhxWXAGK6wscdPzLZOTVIuACPIqGZS4y0YjB/Ur8KrysVpVjJKC0Sl0m/y2DrDA
	 UMob9KieaGXAbdYeptKp3znksgOZQXlSroFAcK4M=
Received: from github.com (hubbernetes-node-dd8b63b.ash1-iad.github.net [10.59.91.31])
	by smtp.github.com (Postfix) with ESMTPA id 29EF5520A7D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 12:50:08 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:50:08 -0700
From: George Kiagiadakis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149990/000000-b2d885@github.com>
Subject: [bluez/bluez] ad8b76: player: Fix crash on MediaItem1.Play() without
 a b...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1149990
  Home:   https://github.com/bluez/bluez
  Commit: ad8b76c8f2ae7ef4704b4a24b69ee7f8e8f9d512
      https://github.com/bluez/bluez/commit/ad8b76c8f2ae7ef4704b4a24b69ee7f8e8f9d512
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  player: Fix crash on MediaItem1.Play() without a browsing scope

media_item_play() dereferenced mp->scope without checking it:

	struct media_folder *folder = mp->scope;
	...
	if (folder->msg)

mp->scope is only ever set by media_player_set_scope(), which is reached
from media_player_set_folder() (SetBrowsedPlayer) and from
media_player_set_folder_by_uid() (ChangeFolder). Both of those require
the player to advertise the Browsing feature bit, since
avrcp_player_parse_features() only creates /Filesystem when
features[7] & 0x08 is set.

The /NowPlaying folder is gated on a different bit, features[8] & 0x02,
and media_player_set_playlist_item() registers its items as playable
MediaItem1 objects regardless of the scope. A player that reports
NowPlaying but not Browsing therefore exports playable items while
mp->scope is still NULL, and calling Play() on one of them crashes
bluetoothd. msg sits at offset 40 in struct media_folder on LP64, which
matches the reported "segfault at 28".

A plain NULL check is not enough: the pending message has nowhere to be
stored, so Play() would answer nothing at all and the caller would hang
instead of crashing. Move the pending request from struct media_folder
to struct media_player instead. Every user of folder->msg already stored
into mp->scope->msg, so the slot was per player in all but name, and
moving it keeps the existing mutual exclusion between ListItems, Search,
ChangeFolder and Play intact.

Playing now works rather than merely not crashing: ct_play_item() picks
the AVRCP scope from the path, so an item under /NowPlaying is played
with the Now Playing scope (0x03).

Moving the message off the folder also fixes a lost reply. Each
completion re-read mp->scope, so when avrcp moved the scope while a
request was pending, for instance on SetBrowsedPlayer, the completion
found a different folder with a NULL msg, returned early and left the
D-Bus caller without an answer.

Fixes: 43b0855abdf4 ("audio/player: Report PlayItem errors")

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: 6d78bde51be5ea9bc9732f0ae67d64be77c6afb9
      https://github.com/bluez/bluez/commit/6d78bde51be5ea9bc9732f0ae67d64be77c6afb9
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  player: Answer pending request when the player is destroyed

media_player_destroy() dropped its reference to the pending request
without answering it. A client with a ListItems(), Search(),
ChangeFolder() or Play() in flight was therefore left waiting for its
own D-Bus timeout to expire, 25s by default, whenever the player went
away. That happens on every AVRCP disconnect, since avrcp destroys the
controller player from its disconnect path.

Reply with org.bluez.Error.Failed instead.

Answering after the g_dbus_unregister_interface() calls above is fine,
as replies are matched by serial rather than by object path, so the
unref site does not need to move.

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: 18863cc028d48e341520347945b46ddf3b280d44
      https://github.com/bluez/bluez/commit/18863cc028d48e341520347945b46ddf3b280d44
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  player: Fix NumberOfItems never being updated on SetBrowsedPlayer

media_player_total_items_complete() discarded the count reported by the
player unless a D-Bus request happened to be pending:

	if (folder == NULL || folder->msg == NULL)
		return;

Of the paths reaching it, only media_player_change_folder_complete()
still holds a pending message. The count was therefore applied on
ChangeFolder and dropped everywhere else, notably on
media_player_set_folder(), which avrcp calls on SetBrowsedPlayer, that
is precisely when the count is first learned.

The guard reads as copy-paste from the four *_complete() functions
above it. Those need a pending message because they send a reply. This
one only refreshes a property, so there is no request to correlate it
with.

f17d3a2c3 replaced an unconditional emit in media_player_change_scope()
with one deferred into this completion whenever the total_items
callback is present, and the guard then swallowed it. The AVRCP
controller always registers that callback, so NumberOfItems has not
been refreshed on SetBrowsedPlayer since. That commit states the
intent itself: "On response, emit PropertyChanged for 'NumberOfItems'
property".

Note the count is still applied to whatever mp->scope is at completion
time rather than to the folder it was requested for.
media_player_change_scope() sets the scope before asking, so the common
case is right, but a second scope change in flight misattributes it.

Fixes: f17d3a2c3b0d ("audio/avrcp: Add support for GetTotalNumberOfItems")

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: a5866844aebf287de1da5a32d37236de54485c1b
      https://github.com/bluez/bluez/commit/a5866844aebf287de1da5a32d37236de54485c1b
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M profiles/audio/player.c

  Log Message:
  -----------
  player: Report EBUSY from a busy Search()

media_folder_search() answered a request that arrived while another one
was still pending with EINVAL, while media_folder_list_items(),
media_folder_change_folder() and media_item_play() all answer EBUSY for
the very same condition.

The commit that added Search copied the error code from the argument
check sitting directly above it, rather than from ChangeFolder, which
had gained the identical busy check four days earlier and used EBUSY.

Fixes: 0a232a434d4b ("audio/player: Add implementation of MediaFolder.Search")

Assisted-by: Claude:claude-opus-5 valgrind


  Commit: b2d88568c2bdde501b149bbdd8f4685676498d99
      https://github.com/bluez/bluez/commit/b2d88568c2bdde501b149bbdd8f4685676498d99
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M .gitignore
    M Makefile.am
    A unit/test-media-player.c

  Log Message:
  -----------
  unit/test-media-player: Add media player tests

Cover the D-Bus surface of profiles/audio/player.c that the AVRCP
controller drives, using a private session bus.

Nine tests:

  play_item_without_scope        Play() on a /NowPlaying item of a
                                 player that never set a scope
  play_item_with_scope           the browsable case still works
  play_item_busy                 a second overlapping Play() is refused
  play_item_busy_with_list_items Play() during a pending ListItems() is
                                 refused, pinning the mutual exclusion
                                 between the two
  list_items_scope_change        a pending ListItems() is still answered
                                 when the scope moves meanwhile
  no_folder_without_scope        MediaFolder1 is not registered without
                                 a scope, which is why MediaItem1 was
                                 the only entry point able to observe
                                 an unset one
  play_item_destroy_pending      destroying a player answers whatever
                                 request is still in flight
  total_items_scope_change       the count reported by the player is
                                 applied when the scope moves
  search_busy                    a busy Search() reports EBUSY

Against the tree before this series play_item_without_scope,
play_item_busy and play_item_destroy_pending crash, all three because
they play a /NowPlaying item on a player with no scope,
list_items_scope_change times out with NoReply, total_items_scope_change
reads a stale count and search_busy reports the wrong error. The
remaining three pass there as well and guard against regressions.

Assisted-by: Claude:claude-opus-5 valgrind


Compare: https://github.com/bluez/bluez/compare/ad8b76c8f2ae%5E...b2d88568c2bd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
