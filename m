Return-Path: <cyrus@holtmann.org>
Date: Wed, 17 Oct 2012 14:49:31 +0200
From: Ludek Finstrle <luf@pzkagis.cz>
To: linux-bluetooth@vger.kernel.org
Subject: Memory leak introduced in commit
 f8619bef3406a2134082dc41c208105fe028c09f
Message-ID: <20121017124931.GA32194@pzkagis.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

  I see memory leak which was introduced in commit f8619bef3406a2134082dc41c208105fe028c09f:
attrib: Fix not checking if att_data_list_alloc fails

It returns (in src/attrib-server.c) from functions when adl local variable is NULL but 
it doesn't free local variables (read_by_group: group; read_by_type: type; find_info: info).

The patch is very easy but I can't test it with head so I don't want to send possible
crapy patch.

Luf
