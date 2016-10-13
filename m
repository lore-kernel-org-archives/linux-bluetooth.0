Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Maxime Chevallier <maxime.chevallier@smile.fr>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
        Maxime Chevallier <maxime.chevallier@smile.fr>
Subject: [PATCH 0/1] GN Master role fails to accept connections
Date: Thu, 13 Oct 2016 15:24:38 +0200
Message-Id: <1476365079-3469-1-git-send-email-maxime.chevallier@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everyone,

The following patch fixes an issue where a GN server would not accept any
incoming connection. The confirm_event function in profiles/network/server.c
would only look for NAP servers when trying to get the server from a 
network adapter.

This patch has the function look for GN servers if no NAP server was found.

I am not quite sure that this patch won't break something else, so please tell
me if this is the wrong way to fix the issue.

Regards,

Maxime

Maxime Chevallier (1):
  profiles/network: look for GN servers to accept incoming connections

 profiles/network/server.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.1.4

