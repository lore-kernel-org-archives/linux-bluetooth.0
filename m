Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32DA18DB01
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603610; cv=none; b=Q3IXXNiKNGtfF4KStQOgd1xbS0uUIy9BoI7vWegBF5tTVOwj8FvunAV7Q4k2yTAr4dOh21LulK/9pZ0qx42Kja4x+JkdeXLYhUvc0w9dmbr7iVx76X1G06axTw3qxTKLCh6uBdkVBAUPydC4eOMvKUd7DSrSvk6NfXg6JX6REuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603610; c=relaxed/simple;
	bh=wpbE5VvYeqMFefCgPPlX6W+QA8fl896nik/iElMIRnU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VBmf75PT658w5qYAZKkOm7JUhePK0j2/wBcN4nP9x+ZP106vOh5wS6kPIUujc5jHCfiYfC9T9xRlARzblXCpGSe6ET416ioerfu4eXhY8JpQPyEhet43VvpHTj78QW9j3NW+nG3RDFZ5nLUrjgqFu4gJtSEM0xjqWfQawWAH2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KsFUCQnA; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KsFUCQnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787603607;
	bh=diyeU5JfCabAEOXIuac1pJRG8B/FOGzpu9O2YDY9Cm4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KsFUCQnAGFqFt9duOY/WNNqyjLOiHt0CGoeBT0sG6HgeBPNuYi/Rb6B67qvGouAGQ
	 5BbXHedzG1zbFPljHIvuT0t2cojv/+Gc/DpeihIeY5fJSffnkvB3YsAJQycxzTQsj1
	 GlYvpl/Bc8SPeNE7SZiUSAkwEwkZZnvgIuxvaK/s=
Received: from github.com (hubbernetes-node-2d47f23.ash1-iad.github.net [10.56.14.60])
	by smtp.github.com (Postfix) with ESMTPA id E1324841333
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 13:33:27 -0700 (PDT)
Date: Mon, 24 Aug 2026 13:33:27 -0700
From: George Kiagiadakis <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/df8f08-9f5adb@github.com>
Subject: [bluez/bluez] 3b3e05: build: Ignore the test-sdp-xml binary
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 3b3e0589b1bbc94f89ee59e410160d6d847a1209
      https://github.com/bluez/bluez/commit/3b3e0589b1bbc94f89ee59e410160d6d847a1209
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Ignore the test-sdp-xml binary

unit/test-sdp-xml has been built by make check ever since the test was
added, but was never added to .gitignore, so it shows up as untracked.

Fixes: e55ff8818f72 ("unit: Add test for sdp_xml_parse_record()")

Assisted-by: Claude:claude-opus-5


  Commit: a8d22214940dd370e26f03df4a880c14d4018202
      https://github.com/bluez/bluez/commit/a8d22214940dd370e26f03df4a880c14d4018202
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

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


  Commit: ede23fb50e4133f2092a8b4b4ad8285b38de7795
      https://github.com/bluez/bluez/commit/ede23fb50e4133f2092a8b4b4ad8285b38de7795
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

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


  Commit: 3215010456f16765123b89575e18db96acbdf6f0
      https://github.com/bluez/bluez/commit/3215010456f16765123b89575e18db96acbdf6f0
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

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


  Commit: a93047cd044fb17d687f43bef95289ec834876b2
      https://github.com/bluez/bluez/commit/a93047cd044fb17d687f43bef95289ec834876b2
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

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


  Commit: 9f5adb00c7c1d3fcfa0afeaf53633eac90b5a927
      https://github.com/bluez/bluez/commit/9f5adb00c7c1d3fcfa0afeaf53633eac90b5a927
  Author: George Kiagiadakis <george.kiagiadakis@collabora.com>
  Date:   2026-08-24 (Mon, 24 Aug 2026)

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


Compare: https://github.com/bluez/bluez/compare/df8f0873a16f...9f5adb00c7c1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
