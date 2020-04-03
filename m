Return-Path: <SRS0=CkcR=5T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A349C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 23:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2E1206CC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Apr 2020 23:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgDCXPF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Apr 2020 19:15:05 -0400
Received: from jax4mhfb02.myregisteredsite.com ([64.69.218.95]:35384 "EHLO
        jax4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbgDCXPE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Apr 2020 19:15:04 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Apr 2020 19:15:03 EDT
Received: from atl4mhob15.registeredsite.com (atl4mhob15.registeredsite.com [209.17.115.53])
        by jax4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 033N5b5S014956
        for <linux-bluetooth@vger.kernel.org>; Fri, 3 Apr 2020 19:05:38 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail01pod5.registeredsite.com [10.30.71.94])
        by atl4mhob15.registeredsite.com (8.14.4/8.14.4) with ESMTP id 033N5asE014293
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Fri, 3 Apr 2020 19:05:36 -0400
Received: (qmail 168384 invoked by uid 0); 3 Apr 2020 23:05:36 -0000
X-TCPREMOTEIP: 208.85.15.155
X-Authenticated-UID: sbrown@opensat.com
Received: from unknown (HELO 155-15-85-208.altiusbb.net) (sbrown@opensat.com@208.85.15.155)
  by 0 with ESMTPA; 3 Apr 2020 23:05:36 -0000
Received: from localhost (localhost [127.0.0.1])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id 1BD4E1540543
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2020 19:05:35 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at ewol.com
Received: from 155-15-85-208.altiusbb.net ([127.0.0.1])
        by localhost (fl-server.ewol.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JFg6C4h89jId for <linux-bluetooth@vger.kernel.org>;
        Fri,  3 Apr 2020 19:05:28 -0400 (EDT)
Received: from w7.lan (w7.lan [192.168.1.9])
        by 155-15-85-208.altiusbb.net (Postfix) with ESMTP id DED1F1540459
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2020 19:05:28 -0400 (EDT)
Message-ID: <65249ba1d4762186088e6b4496508510e0a06d93.camel@ewol.com>
Subject: mesh: test/test-mesh fails to provision node
From:   Steve Brown <sbrown@ewol.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 03 Apr 2020 19:05:28 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

test/test-mesh can no longer provision a node.

mesh-cfgclient correctly provisions the same node.

In poking around with d-feet, the interface
org.freedesktop.DBus.Properties isn't created by test/test-mesh, but is
by mesh-cfgclient.

Steve

================

test/test-mesh fails with:

create
Creating with UUID 0e04050a0b090d0c0108060f0a020307
Created mesh network with token bb0f18f8901f3587
Attach mesh node to bluetooth-meshd daemon
Mesh app registered: /org/bluez/mesh/node0e04050a0b090d0c0108060f0a020307
scan
Scanning...
Scan procedure started
ScanResult >> RSSI: -34 UUID: acda451feca3903e4560f6a3a25a437a OOB Data: 0000
uuid
Enter 32-digit hex remote UUID:
acda451feca3903e4560f6a3a25a437a
add
Adding dev UUID acda451feca3903e4560f6a3a25a437a
AddNode procedure failed  org.bluez.mesh.Error.Failed: Failed to start provisioning initiator

=====================================

syslog:

Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]: mesh/manager.c:add_node_call() AddNode request
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]: mesh/manager.c:scan_cancel() scan_cancel
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]: Agent failed (org.freedesktop.DBus.Error.UnknownMethod), Traceback (most recent call last):
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]:   File "/usr/lib/python3/dist-packages/dbus/service.py", line 658, in _message_cb
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]:     (candidate_method, parent_method) = _method_lookup(self, method_name, interface_name)
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]:   File "/usr/lib/python3/dist-packages/dbus/service.py", line 248, in _method_lookup
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]:     raise UnknownMethodException('%s is not a valid method of interface %s' % (method_name, dbus_interface))
Apr  3 18:41:10 mesh0 bluetooth-meshd[6648]: dbus.exceptions.UnknownMethodException: org.freedesktop.DBus.Error.UnknownMethod: Unknown method: GetAll is not a valid method of interface org.

=============================================

dbus-monitor log:

method call time=1585918004.102388 sender=:1.409 -> destination=:1.301 serial=14 path=/org/bluez/mesh/node0a060d08020f03050b090c0a07010e04; interface=org.bluez.mesh.Management1; member=AddNode
   array of bytes [
      ac da 45 1f ec a3 90 3e 45 60 f6 a3 a2 5a 43 7a
   ]
   array [
   ]
method call time=1585918004.104726 sender=:1.301 -> destination=:1.409 serial=307 path=/mesh/test/agent; interface=org.freedesktop.DBus.Properties; member=GetAll
   string "org.bluez.mesh.ProvisionAgent1"
error time=1585918004.110353 sender=:1.409 -> destination=:1.301 error_name=org.freedesktop.DBus.Error.UnknownMethod reply_serial=307
   string "Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/dbus/service.py", line 658, in _message_cb
    (candidate_method, parent_method) = _method_lookup(self, method_name, interface_name)
  File "/usr/lib/python3/dist-packages/dbus/service.py", line 248, in _method_lookup
    raise UnknownMethodException('%s is not a valid method of interface %s' % (method_name, dbus_interface))
dbus.exceptions.UnknownMethodException: org.freedesktop.DBus.Error.UnknownMethod: Unknown method: GetAll is not a valid method of interface org.freedesktop.DBus.Properties
"
error time=1585918004.112011 sender=:1.301 -> destination=:1.409 error_name=org.bluez.mesh.Error.Failed reply_serial=14
   string "Failed to start provisioning initiator"


signal time=1585918441.305863 sender=:1.2 -> destination=(null destination) serial=176 path=/org/freedesktop/timesync1; interface=org.freedesktop.DBus.Properties; member=PropertiesChanged
   string "org.freedesktop.timesync1.Manager"
   array [
      dict entry(


