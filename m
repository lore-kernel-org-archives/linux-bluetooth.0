Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 0/4] Enabling notifications using the Generic Attribute API
Date: Fri, 11 Nov 2011 21:20:05 -0300
Message-Id: <1321057209-24931-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These are just a few patches that I have around that helped tests here.

In the last BlueZ meeting, a aproach similar to this was discussed and
seemed that the right aproach was to enable notifications/indications
for services automatically when they support it. This email is more
for re-starting the discussion.

Cheers,
--

Vinicius Costa Gomes (4):
  Add a way to manually configure the CCC attribute of a Characteristic
  Add a way to enable notifications using the CCC descriptor
  Update test-attrib to handle notifications and indications
  Fix responding indications and notifications with not supported

 attrib/client.c       |  131 ++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/attribute-api.txt |    7 +++
 src/attrib-server.c   |    4 ++
 test/test-attrib      |   45 ++++++++++++++++-
 4 files changed, 184 insertions(+), 3 deletions(-)

--
1.7.7

