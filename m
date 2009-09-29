Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 29 Sep 2009 10:47:08 -0300
Message-ID: <f9d4bd30909290647ue3e5131oc14baf3d6aa2a334@mail.gmail.com>
Subject: [PATCH] obex-client API - Missing method
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel/Johan,

"Close" method  description on Session interface is missing, I added a
brief description on my branch "devel":

git://git.infradead.org/users/cktakahasi/obexd.git devel

BTW, CopyFile and MoveFile are not implemented yet, we need to remove
the code or write in the API  that it is not implemented yet.

Br,
Claudio.
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
