Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/README: Update documention with Android 5 info
Date: Thu, 20 Nov 2014 18:24:55 +0100
Message-Id: <1416504295-18224-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/README | 84 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/android/README b/android/README
index b1ac886..aa12e51 100644
--- a/android/README
+++ b/android/README
@@ -9,14 +9,13 @@ replacement to Android provided Bluetooth stack.
 More details about BlueZ for Android architecture and components can be found
 in android/hal-ipc-api.txt file.
 
-Supported Android version: 4.4
+Supported Android version: 4.4 KitKat and 5.0 Lollipop
 
 
 Building and running on Android
 ===============================
 
-Steps needed to build and run Android Open Source Project 4.4 with
-integrated BlueZ.
+Steps needed to build and run Android Open Source Project with integrated BlueZ.
 
 
 Build requirements
@@ -30,11 +29,10 @@ is available at https://code.google.com/p/aosp-bluez.glib/
 'external/bluetooth/sbc' directory. Library is build from Android.mk provided
 by BlueZ. SBC code is available at git://git.kernel.org/pub/scm/bluetooth/sbc
 
-- Bionic support - Currently only 'master' branch available at
-https://android.googlesource.com/platform/bionic provides all required
-functionality and running BlueZ on release branch requires backporting missing
-features (currently epoll_create1 and ppoll calls for Android 4.4). Sample
-Bionic for Android 4.4 with all required features backported is available at
+- Bionic support - Android 5.0 provides all required functionality. Running
+BlueZ on Android 4.4 requires backporting missing features (epoll_create1 and
+ppoll calls). Sample Bionic for Android 4.4 with all required features
+backported is available at
 https://code.google.com/p/aosp-bluez.platform-bionic/
 
 Runtime requirements
@@ -49,29 +47,44 @@ import init.bluetooth.rc
 
 For convenience examples are provided at:
 https://code.google.com/p/aosp-bluez.device-lge-mako/    (Nexus 4)
+https://code.google.com/p/aosp-bluez.device-lge-ham/     (Nexus 5)
 https://code.google.com/p/aosp-bluez.device-asus-flo/    (Nexus 7 2013)
 
+Security-Enhanced Linux in Android
+----------------------------------
+
+Since 5.0 release Android moved to full enforcement of SELinux. This requires
+proper policy to be provided for all BlueZ for Android services (and services
+interacting with BlueZ). Policies should be placed in external/selinux/ path.
+
+Required policy files are provided at <TBD>.
+
+For convenience sepolicy.git with all required policies is available at:
+https://code.google.com/p/aosp-bluez.external-sepolicy/
 
 Downloading and building
 ------------------------
 
-Building for Android requires full Android AOSP source tree. Sample Android
-4.4 tree with all required components present is available at
+Building for Android requires full Android AOSP source tree. Sample Android tree
+with all required components present is available at
 http://code.google.com/p/aosp-bluez/
 
-This tree provides support for Nexus4 (target aosp_mako-userdebug) and
-Nexus 7 2013 (target aosp_flo-userdebug). Tree does not provide binary blobs
-needed to run Android on supported devices. Those can be obtained from
+This tree provides support for Nexus4 (mako), Nexus 5 (hammerhead) and
+Nexus 7 2013 (flo, deb). Tree does not provide binary blobs needed to run
+Android on supported devices. Those can be obtained from
 https://developers.google.com/android/nexus/drivers. Binary blobs needs to be
 unpacked (EULA acceptance required) into 'vendor' directory of Android tree.
 
 Downloading:
-repo init -u https://code.google.com/p/aosp-bluez.platform-manifest -b kitkat
+Android 5.0 - 'lollipop' branch
+Android 4.4 - 'kitkat' branch
+
+repo init -u https://code.google.com/p/aosp-bluez.platform-manifest -b lollipop
 repo sync
 
 Building:
 source build/envsetup.sh
-lunch aosp_mako-userdebug    or    lunch aosp_flo-userdebug
+lunch aosp_<target>-userdebug
 make -j8
 
 Flashing:
@@ -263,21 +276,23 @@ initial     - only initial implementations is present, Android Framework is
               able to initialize but most likely not able to use it
 not started - no implementation, Android Framework is not able to initialize it
 
-Profile ID    HAL header         Status
----------------------------------------
-core          bluetooth.h        complete
-a2dp          bt_av.h            complete
-gatt          bt_gatt.h          complete
-              bt_gatt_client.h   complete
-              bt_gatt_server.h   complete
-handsfree     bt_hf.h            complete
-hidhost       bt_hh.h            complete
-health        bt_hl.h            complete
-pan           bt_pan.h           complete
-avrcp         bt_rc.h            complete
-socket        bt_sock.h          complete
-hf_client     bt_hf_client.h     initial
-map_client    bt_mce.h           complete
+Profile ID        HAL header         4.4 Status    5.0 status
+-------------------------------------------------------------
+core              bluetooth.h        complete      partial
+a2dp              bt_av.h            complete      complete
+gatt              bt_gatt.h          complete      partial
+                  bt_gatt_client.h   complete      partial
+                  bt_gatt_server.h   complete      partial
+handsfree         bt_hf.h            complete      partial
+hidhost           bt_hh.h            complete      complete
+health            bt_hl.h            complete      complete
+pan               bt_pan.h           complete      complete
+avrcp             bt_rc.h            complete      complete
+socket            bt_sock.h          complete      partial
+handsfree_client  bt_hf_client.h     N/A           partial
+map_client        bt_mce.h           N/A           complete
+a2dp_sink         bt_av.h            N/A           partial
+avrcp_ctrl        bt_rc.h            N/A           partial
 
 
 Implementation shortcomings
@@ -344,11 +359,6 @@ methods:
 client->set_adv_data               missing kernel support for vendor data
 client->connect                    is_direct parameter is ignored
 
-HAL HF Client
--------------
-
-Available on Android only when BLUEZ_EXTENSIONS flag set in BoardConfig.mk
-
 
 Audio SCO HAL
 =============
@@ -387,6 +397,10 @@ affect qualification or user experience. This section provides list of
 recommended Android fixes that are not part of latest AOSP release supported by
 BlueZ.
 
+For Android 5.0 Lollipop:
+<TBD>
+
+For Android 4.4 KitKat:
 https://android-review.googlesource.com/82757
 https://android-review.googlesource.com/87670
 https://android-review.googlesource.com/88384
-- 
1.9.1

