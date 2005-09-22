Return-Path: <lcapitulino@conectiva.com.br>
Date: Thu, 22 Sep 2005 18:04:29 -0300
From: Luiz Fernando Capitulino <lcapitulino@conectiva.com.br>
To: marcel@holtmann.org
Cc: bluez-devel@lists.sourceforge.net
Subject: [PATCH 0/2] - Errno overwrite fixes.
Message-Id: <20050922180429.59bfc0ca.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Marcel,

In the next two e-mails I will send two minor fixes for 'errno' overwrite bugs.

[PATCH 1/2] - Fixes errno overwrite in hci_for_each_dev().
[PATCH 2/2] - Fixes errno overwrite in sdp_connect().

Didn't test it too mutch, but I hope it helps.
