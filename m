Return-Path: <cyrus@holtmann.org>
Message-ID: <1336391383.4325.24.camel@jlt3.sipsolutions.net>
Subject: batostr() function
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Date: Mon, 07 May 2012 13:49:43 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Really? 2 static buffers that are used alternately based on a static
variable? How can that possibly be thread-safe? That may work in very
restricted scenarios, but ...

johannes

