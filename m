Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [GATT] Query about GATT client and server HAL interfaces
Date: Thu, 29 Sep 2016 17:33:20 +0530
Message-id: <1475150600-1405-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear All,
  The GATT client interface (bt_gatt_client.h) has API's like listen (for start\stop advetisement) as well
as Multi adv enable\disable\data set API's (although Multi Adv api'S are not currently supported)

Although, GAP peripheral\central roles are not tied to GATT server\CLient roles,
but it seems as per HAL interface, an application implementing GATT server role by using HAL Gatt server interface, can not do advertising,
whereas, an application implementing GAP client role can by using listen() API?

Normally it is GATT server which hosts services and does advertisement and eventually listens to incoming connection.
Therefore, is the above design of API's has some specific meaning in the bluedroid stack context? Please help me understand.

Apart from above, the advertisement related fucntions are LE adapter specific and ideAlly should be separated from GATT interfaces
Perhaps, the upstream AOSP project has already separated out the LE Adv functionalities except the listen() function which is still present
in GATT client interface explained above.
Do we have any plan to separate them out in near future for BFA?

Thank You in advance for your valuable inputs.

BR,
-Anupam Roy

Signed-off-by: Anupam Roy <anupam.r@samsung.com>
---
 mail | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 mail

diff --git a/mail b/mail
new file mode 100644
index 0000000..e69de29
-- 
1.9.1

