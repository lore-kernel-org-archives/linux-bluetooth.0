Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A20130E3B
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636321; cv=none; b=doqKdZoR+PoymLyMWsrXcca+IEsxP44XACXVSaS4TwJ1jBLCi03esgVuN208L9qZX/h8i9z0vtkbINQo5moqgxtBWAhY29bGjS8l2s241zI4iXjoHGJ/EJFOFeQFZab3m+TsrjxR1qm/jp7OXOUgeT8/6fsEQ6lj7D389pQVX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636321; c=relaxed/simple;
	bh=D72e2/+sA4eNb3diK5Qqx+NbOXkyz01Q2tGiXqI3PvQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MOQLbuz0ekdu/E0WMEePIvvG2np7e3bAs8PwGnslIFjE2LEJy0ZBvlq7BLJ2I+MocI4RGhmgOujzioNjEa6o5SNx00aheP42pVNwdlaZYTn/q5ovEdS4HuK9Nd40yAyh4QG1Alxqh8dvarRzJ567jXLZo3kjGjPBPM+T07IZHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iVUkb5R7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iVUkb5R7"
Received: from github.com (hubbernetes-node-4bf663e.ac4-iad.github.net [10.52.150.41])
	by smtp.github.com (Postfix) with ESMTPA id 9103C7006B3
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 07:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1711636317;
	bh=FnHeFPlC8Aeh/Tud71N4blGurFhdcfFLqcUtA12N+rY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iVUkb5R7gYKxLPQ3QvG1tnM16L6nAIO7iev262TtiWU6Y/YYwnshusnNLkh8CSBip
	 sF//eopZlv20M3eIIG7QC+qWwRLuPdw/wXuQWQGlPJjUqoFLHA4CQ8W4o/kxwhR+fX
	 JUqOmROf3CYnutgP8CygZ5c88ZK4t4aRs+nufpsM=
Date: Thu, 28 Mar 2024 07:31:57 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/41d6c4-3403f6@github.com>
Subject: [bluez/bluez] 868d8f: shared/shell: Add script command
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 868d8fc5dcf60ada2e509b6d13a3f86b57181080
      https://github.com/bluez/bluez/commit/868d8fc5dcf60ada2e509b6d13a3f=
86b57181080
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-26 (Tue, 26 Mar 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add script command

This adds script command to main menu which can be used to execute
scripts at any point rather than just at the init.


  Commit: e6d849f38be30d4a27262c0a8b6c651aac0d79c9
      https://github.com/bluez/bluez/commit/e6d849f38be30d4a27262c0a8b6c6=
51aac0d79c9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-26 (Tue, 26 Mar 2024)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Add commands from scripts to history

This enables saving the commands run from a script to also be visible in
the history.


  Commit: cd22ff6a1fef6a89e7ee8fe64a9613b85a33e48d
      https://github.com/bluez/bluez/commit/cd22ff6a1fef6a89e7ee8fe64a961=
3b85a33e48d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-03-27 (Wed, 27 Mar 2024)

  Changed paths:
    M monitor/att.c
    M monitor/display.h

  Log Message:
  -----------
  monitor/att: Add support for decoding GATT Long Reads

This adds support for decoding GATT Long Reads:

< ACL Data TX: Handle 3585 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0028 Type: Report Map (0x2a4b)
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Response (0x0b) len 22
        Value[22]: 05010902a10185020901a10095107501150025010509
        Long Value[22]: 05010902a10185020901a10095107501150025010509
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x0016
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Blob Response (0x0d) len 22
        Value[22]: 19012910810205011601f826ff07750c950209300931
        Long Value[44]: 05010902a10185020901a1009510750115002501050919
                        012910810205011601f826ff07750c950209300931
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x002c
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Blob Response (0x0d) len 22
        Value[22]: 81061581257f75089501093881069501050c0a380281
        Long Value[66]: 05010902a10185020901a1009510750115002501050919
                        012910810205011601f826ff07750c9502093009318106
                        1581257f75089501
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x0042
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Blob Response (0x0d) len 22
        Value[22]: 06c0c00643ff0a0202a101851175089513150026ff00
        Long Value[88]: 05010902a10185020901a1009510750115002501050919
                        012910810205011601f826ff07750c9502093009318106
                        1581257f75089501093881069501050c0a38028106c0c0
                        0643ff0a0202a101851175089513150026ff00
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x0058
> ACL Data RX: Handle 3585 flags 0x02 dlen 14
      ATT: Read Blob Response (0x0d) len 9
        Value[9]: 0902810009029100c0
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Value[97]: 05010902a10185020901a1009510750115002501050919
                   012910810205011601f826ff07750c9502093009318106
                   1581257f75089501093881069501050c0a38028106c0c0
                   0643ff0a0202a101851175089513150026ff0009028100
                   09029100c0


  Commit: 07d427227a1ba2f062cb108b79c868b938528eb6
      https://github.com/bluez/bluez/commit/07d427227a1ba2f062cb108b79c86=
8b938528eb6
  Author: Youwan Wang <youwan@nfschina.com>
  Date:   2024-03-28 (Thu, 28 Mar 2024)

  Changed paths:
    M obexd/src/manager.c

  Log Message:
  -----------
  obexd: Fix "Size" use g_dbus_emit_property_changed_full() to emit

This is the comment for g_dbus_emit_property_changed()
/*
 * Note that when multiple properties for a given object path are changed=

 * in the same mainloop iteration, they will be grouped with the last
 * property changed. If this behaviour is undesired, use
 * g_dbus_emit_property_changed_full() with the
 * G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH flag, causing the signal to ignore
 * any grouping.
 */

When receiving a "small file" through Bluetooth, When using Blueman to
transfer files to the configured directory, "small files" in the cache
will not be moved to the configured directory. Debugging found that the
three properties "Size" "Transferred" and "complete" were reported at onc=
e
through the g_dbus_emit_property_changed function, but the "Size" propert=
y
did not have a value, it appears that there are the following errors
"UnicodeDecodeError: 'utf-8' codec can't decode byte 0xb5 in position 0:
invalid start byte" in Blueman log.
So let the "Size" property use g_dbus_emit_property_changed_full to
single emit, if use g_dbus_emit_property_changed=EF=BC=88grouped=EF=BC=89=
to emit,
there is a possibility that "Size" property value has been freed

The following is the issue log

dbus-monitor log:

signal time=3D1710900297.140618 sender=3D:1.50 -> destination=3D(null)
serial=3D59 path=3D/org/bluez/obex/server/session4/transfer3;
interface=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged

   string "org.bluez.obex.Transfer1"
   array [
      dict entry(
         string "Status"
         variant             string "complete"
      )
      dict entry(
         string "Transferred"
         variant             uint64 0
      )
   ]
   array [
      string "Size"
   ]
method call time=3D1710900297.141361 sender=3D:1.39 -> destination=3D:1.5=
0
serial=3D417 path=3D/org/bluez/obex/server/session4/transfer3;
 interface=3Dorg.freedesktop.DBus.Properties; member=3DGet

   string "org.bluez.obex.Transfer1"
   string "Size"
error time=3D1710900297.141596 sender=3D:1.50 -> destination=3D:1.39
error_name=3Dorg.freedesktop.DBus.Error.InvalidArgs reply_serial=3D417

   string "No such property 'Size'"

blueman log

blueman.desktop[2368]: blueman-applet 09.42.04 DEBUG
Transfer:25 do_g_properties_changed: /org/bluez/obex/server/session2/
transfer1 Transferred 0
blueman.desktop[2368]: blueman-applet 09.42.04 DEBUG
Base:74 do_g_properties_changed: /org/bluez/obex/server/session2
{'Source': 'xxx', 'Destination': 'xxx', 'Root': 'xxx/.cache/obexd'}
blueman.desktop[2368]: blueman-applet 09.42.04 ERROR
TransferService:97 _authorize_push: Failed to get StatusIcon
blueman.desktop[2368]: blueman-applet 09.42.15 INFO
Notification:239 do_g_signal: accept
blueman.desktop[2368]: blueman-applet 09.42.15 INFO
TransferService:57 on_action : Action accept
blueman.desktop[2368]: blueman-applet 09.42.15 INFO
Notification:239 do_g_signal: 3
blueman.desktop[2368]: blueman-applet 09.42.15 DEBUG
Notification:247 do_g_signal: The notification was closed by a call
to CloseNotification.
blueman.desktop[2368]:UnicodeDecodeError: 'utf-8' codec can't decode byte=

0xb5 in position 0: invalid start byte
blueman.desktop[2368]: blueman-applet 09.42.15 INFO
Manager:73 _on_object_removed: /org/bluez/obex/server/session2/transfer1
blueman.desktop[2368]: blueman-applet 09.42.15 INFO
Manager:80 _on_object_removed: /org/bluez/obex/server/session2

After fix, The following log

dbus-monitor log:

signal time=3D1711000976.672383 sender=3D:1.724 -> destination=3D(null)
serial=3D18 path=3D/org/bluez/obex/server/session1/transfer0;
interface=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged

   string "org.bluez.obex.Transfer1"
   array [
      dict entry(
         string "Size"
         variant             uint64 50
      )
   ]
   array [
   ]
signal time=3D1711000976.672483 sender=3D:1.724 -> destination=3D(null)
serial=3D19 path=3D/org/bluez/obex/server/session1/transfer0;
interface=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged

   string "org.bluez.obex.Transfer1"
   array [
      dict entry(
         string "Status"
         variant             string "complete"
      )
      dict entry(
         string "Transferred"
         variant             uint64 0
      )
   ]
   array [
   ]

blueman log

blueman.desktop[2368]: blueman-applet 14.13.29 DEBUG
Transfer:25 do_g_properties_changed: /org/bluez/obex/server/session2/
transfer1 Transferred 0
blueman.desktop[2368]: blueman-applet 14.13.29 DEBUG
Base:74 do_g_properties_changed: /org/bluez/obex/server/session2
{'Source': 'xxx', 'Destination': 'xxx', 'Root': 'xxx'}
blueman.desktop[2368]: blueman-applet 14.13.29 ERROR
TransferService:97 _authorize_push: Failed to get StatusIcon
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
Notification:239 do_g_signal: accept
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
TransferService:57 on_action : Action accept
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
Notification:239 do_g_signal: 3
blueman.desktop[2368]: blueman-applet 14.13.36 DEBUG
Notification:247 do_g_signal: The notification was closed by a call to
CloseNotification.
blueman.desktop[2368]: blueman-applet 14.13.36 DEBUG
Transfer:25 do_g_properties_changed: /org/bluez/obex/server/session2/
transfer1 Size 50
blueman.desktop[2368]: blueman-applet 14.13.36 DEBUG
Transfer:25 do_g_properties_changed: /org/bluez/obex/server/session2/
transfer1 Status complete
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
Manager:86 _on_transfer_completed: /org/bluez/obex/server/session2/
transfer1 True
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
TransferService:275 _on_transfer_completed: Destination file exists,
renaming to: xxx.txt
blueman.desktop[2368]: blueman-applet 14.13.36 ERROR
TransferService:256 _notify_kwargs: No statusicon found
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
TransferService:241 _add_open : adding action
blueman.desktop[2368]: blueman-applet 14.13.36 DEBUG
Transfer:25 do_g_properties_changed: /org/bluez/obex/server/session2/
transfer1 Transferred 0
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
Manager:73 _on_object_removed: /org/bluez/obex/server/session2/transfer1
blueman.desktop[2368]: blueman-applet 14.13.36 INFO
Manager:80 _on_object_removed: /org/bluez/obex/server/session2

Signed-off-by: Youwan Wang <youwan@nfschina.com>


  Commit: 0ff7392af164e5c5453722bd4adb780190db33ea
      https://github.com/bluez/bluez/commit/0ff7392af164e5c5453722bd4adb7=
80190db33ea
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-03-28 (Thu, 28 Mar 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix MediaEndpoint prop codec for bcast src endpoint

Fix MediaEndpoint prop codec returns 0 for bcast src endpoint


  Commit: f4c40dc4107e89b1ef025b3c8102ea9da720d3c6
      https://github.com/bluez/bluez/commit/f4c40dc4107e89b1ef025b3c8102e=
a9da720d3c6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-03-28 (Thu, 28 Mar 2024)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Remove POLLOUT check from bt_io_bcast_accept

For the Broadcast Sink defer setup scenario, there is no need to check
for the POLLOUT event on the PA sync socket before calling "read" to
issue the Create BIG sync command. This check has been inherited from
unicast, but it is unnecessary for broadcast, since currently after
accept and read, the event to signal BIG sync established is G_IO_IN.


  Commit: 3403f65e266a0c40ace9cecc868fa96ad3335920
      https://github.com/bluez/bluez/commit/3403f65e266a0c40ace9cecc868fa=
96ad3335920
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-03-28 (Thu, 28 Mar 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Separate iso_defer_accept into dedicated functions

This separates the iso_defer_accept function into dedicated ones for
unicast/broadcast, since the flow is different for each scenario:
For unicast, POLLOUT is checked on socket before calling read and
adding a G_IO_OUT watch. Checking for POLLOUT is not necessary for
broadcast, since currently this event is never generated on the
child socket. Instead, G_IO_IN is generated after BIG sync is
established and a BIS socket is ready to be accepted.


Compare: https://github.com/bluez/bluez/compare/41d6c4e1c92f...3403f65e26=
6a

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
