Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 9 Feb 2015 22:10:21 +0530
Message-ID: <CAE2MWk=4BB_VFrNwo+yY9A+yT_FwCAHhLQG9_c7gZwVUon6cew@mail.gmail.com>
Subject: [PATCH] Bluetooth: Restrict access for raw-only controllers
From: Ujjal Roy <royujjal@gmail.com>
To: marcel@holtmann.org
Cc: majordomo@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>>  /* Clear flags */
>> - hdev->flags = 0;
>> + hdev->flags &= BIT(HCI_RAW);

Is it for clearing the HCI_RAW flag? If so then it should be as below
am I right?

  /* Clear flags */
- hdev->flags = 0;
+ hdev->flags &= ~BIT(HCI_RAW);


Thanks,
UjjaL Roy
