Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C579C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452201; cv=none; b=WYh4OAFcKET2SXdaeC2T5P3uspeAVtQNkVRB9qun0mMdgRlDraf82NZRRIiNMWEDwA9yJwa7blW6xOZipQFgRYvCfcEQ8cLF3iejkMDK5/u9Dj3QlWxCm7Y31i9ItT0aznLniD8IEipNoAqGf8Z7uhcr7+vIpjr9RRK66EG1jcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452201; c=relaxed/simple;
	bh=BxfTwYGEc/8kocBwn0fRMRRqRGuAsafv3LZ3D+3JGQo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HCjAQpM43PhAtBdr4G5NW4F2Jv/kIJN0bcG4/c29aYCWTZAMLcgYYyRczDGZe2BUnDjKk1ofr9W2vX5E0wVO4gic/eJ9GW4rv7+veyKSv4DJb8g1hnS075Zg2hrdd8gw1huCg2S8gDEE/7HIp0X09Pz46OT6yb8jn22Ygtv/64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Tl0FaA/x; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Tl0FaA/x"
Received: from github.com (hubbernetes-node-08ca2c2.va3-iad.github.net [10.48.205.114])
	by smtp.github.com (Postfix) with ESMTPA id 178394E0B4C
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Mar 2025 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1743452199;
	bh=cWbP+AH3q9K0TBmywSkeIFznOGQz5ftVROy5gRgFVlg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Tl0FaA/xsZmh31224c41b7ssMTrFRgaAmH8CjzkYB+5BoCQxcGNbuCcfWHWowH7nQ
	 p5jxeZGV+DTz3ZY8aoHFhADez9Md5jRP0FtHqqyzA3ffMJQV5gsKN57JGzzE0byXfo
	 v7Bl+ApOCZKjH17ZbPUrli3joEMtMUsUK2HdxDQs=
Date: Mon, 31 Mar 2025 13:16:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d9430c-cdd02a@github.com>
Subject: [bluez/bluez] cdd02a: dbus: Fix add invalid memory during interface
 removal
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
  Commit: cdd02afbb7eff7aa1bb9f9e8a7b6e0b8321d323c
      https://github.com/bluez/bluez/commit/cdd02afbb7eff7aa1bb9f9e8a7b6e0b8321d323c
  Author: Shuai Zhang <quic_shuaz@quicinc.com>
  Date:   2025-03-31 (Mon, 31 Mar 2025)

  Changed paths:
    M gdbus/object.c

  Log Message:
  -----------
  dbus: Fix add invalid memory during interface removal

test setp
register_service <uuid>
register_application <uuid>
unregister_service <uuid>
unregister_application
register_service <uuid>
register_application <uuid>
core dump

invalidate_parent_data is called to add the service to the application's
glist when unregister_service. However, this service has already been
added to the glist of root object in register_service. This results in
services existing in both queues,but only the services in the
application's glist are freed upon removal. A null address is stored
in root object's glist, a crash dump will occur when get_object is called.

Add a check for the parent pointer to avoid adding the service again.

0  0x0000007ff7df6058 in dbus_message_iter_append_basic ()
   from /usr/lib/libdbus-1.so.3
1  0x00000055555a3780 in append_object (data=0x31306666,
  user_data=0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:1117
2  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
3  0x00000055555a37ac in append_object (data=0x5555642cf0,
  user_data=0x7ffffff760) at /usr/src/debug/bluez5/5.72/gdbus/object.c:1122
4  0x0000007ff7ece0cc in g_slist_foreach () from /usr/lib/libglib-2.0.so.0
5  0x00000055555a3630 in get_objects (connection=<optimized out>,
    message=<optimized out>, user_data=0x555563b390)
    at /usr/src/debug/bluez5/5.72/gdbus/object.c:1154
6  0x00000055555a51d0 in process_message (
    connection=connection@entry=0x5555639310,
    message=message@entry=0x5555649ac0,
    method=method@entry=0x55555facf8 <manager_methods>,
    iface_user_data=<optimized out>)
    at /usr/src/debug/bluez5/5.72/gdbus/object.c:246
7  0x00000055555a575c in generic_message (connection=0x5555639310,
    message=0x5555649ac0, user_data=<optimized out>)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
