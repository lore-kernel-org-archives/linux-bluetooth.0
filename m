Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 24 Feb 2010 15:33:32 +0800
Message-ID: <6aeb672b1002232333u54dbc04qd1f119cccef5febf@mail.gmail.com>
Subject: Re: Read default link policy from main.conf - draft change for
	comments
From: Liang Bao <tim.bao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've added a configuration item DisableParkState in main.conf and let
the bluetoothd check this. If it's set to true, the
main_opts.link_policy will be HCI_LP_RSWITCH | HCI_LP_SNIFF |
HCI_LP_HOLD, otherwise, it will be original one -
HCI_LP_RSWITCH | HCI_LP_SNIFF | HCI_LP_HOLD | HCI_LP_PARK. Any comment
on the code change or the way to configure? I just want to see if
further improvement is necessary before I send out the patch. Thanks.

diff --git a/data/main.conf b/data/main.conf
index 8153eb2..b9b8fef 100644
--- a/data/main.conf
+++ b/data/main.conf
@@ -57,3 +57,8 @@ ReverseServiceDiscovery = true
 # Enable name resolving after inquiry. Set it to 'false' if you don't need
 # remote devices name and want shorter discovery cycle. Defaults to 'true'.
 NameResolving = true
+
+# Disable park state support helps some bluetooth device stably connected, e.g.
+# Motorola HF850 car-kit will lose connection or fail to setup SCO when it's
+# in park state. Defaults to 'false'.
+DisableParkState = true

diff --git a/src/main.c b/src/main.c
index ff423a4..e0ec7ce 100644
--- a/src/main.c
+++ b/src/main.c
@@ -203,8 +203,15 @@ static void parse_config(GKeyFile *config)

        main_opts.link_mode = HCI_LM_ACCEPT;

        main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
-                                               HCI_LP_HOLD | HCI_LP_PARK;
+                                               HCI_LP_HOLD ;
+        boolean = g_key_file_get_boolean(config, "General",
+                                                "DisableParkState", &err);
+        if (err)
+                g_clear_error(&err);
+        else if (!boolean)
+               main_opts.link_policy |= HCI_LP_PARK;
 }




2010/2/10 Liang Bao <tim.bao@gmail.com>:
> Anyone could advice? Thanks.
>
> 2010/2/8 Liang Bao <tim.bao@gmail.com>:
>> Hi,
>>
>> We noticed that currently BlueZ doesn't read link policy settings from
>> main.conf as it does for other things such as General.Name or
>> General.Class. It just enable everything in parse_config()
>> (src/main.c). Is this just due to lack of use case or BlueZ does this
>> intentionally for some reason? Thanks.
>>
>>
>> 86 static void parse_config(GKeyFile *config)
>> 87 {
>> .....
>> 206         main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
>> 207                                                 HCI_LP_HOLD | HCI_LP_PARK;
>> 208 }
>>
>
