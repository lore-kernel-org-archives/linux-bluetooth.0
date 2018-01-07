Return-Path: <viro@ftp.linux.org.uk>
Date: Sun, 7 Jan 2018 20:06:56 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: [bluetooth/hidp] upper bound on hidp_connadd_req->rd_size in
 HIDPCONNADD
Message-ID: <20180107200656.GC13338@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

	Shouldn't it be limited to HID_MAX_DESCRIPTOR_SIZE?
Or is it really "anything up to 64Kb"?
