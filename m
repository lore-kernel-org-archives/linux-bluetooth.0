Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: VISHWANATH KM <a21174@motorola.com>
Date: Wed, 28 Sep 2011 12:27:35 +0530
Message-ID: <CACbkbU+i7peciUG-pynE+ApDxDq5XL18W=CaD1utYCyKRO0+_w@mail.gmail.com>
Subject: [RFC] Need to unref and free user data in gatt_find_info for plen 0 case
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Please provide comments on below. thx
1. In gatt_find_info if start handle > end handle , then still we
issue ATT_Find_Info_Req and receive response from remote device as
invalid handle, its ok though from spec point of view but however its
an overhead which can be reduced with below check.
2. In gatt_find_info with plen 0, it needs unref and freeing user_data
as the descriptor_cb won't be triggered in this case, and there will
be a reference count mismatch.
below change takes care of both,

-        if (plen == 0)
+       if (plen == 0 || start > end) {
+               g_attrib_unref(attrib);
+               g_free(user_data);
                 return 0;
+       }


Regards
Vishwanath
