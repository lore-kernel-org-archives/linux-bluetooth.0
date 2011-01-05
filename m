Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Jan 2011 14:48:34 +0300
From: Ilya Basin <basinilya@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Message-ID: <1769727890.20110105144834@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: listening socket not notified when bluetoothd stops, but becomes unusable
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I use nonblocking sockets and select(). When I restart bluetoothd,
select() doen't return, but the listening socket won't accept
connections anymore. How to handle this correctly?

