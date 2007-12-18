Return-Path: <cyrus@holtmann.org>
Message-ID: <4767CC25.3060309@aircable.net>
Date: Tue, 18 Dec 2007 10:33:25 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: russogia4@libero.it
References: <JT8M43$561AFF24392062823768CC682BF19784@libero.it>
In-Reply-To: <JT8M43$561AFF24392062823768CC682BF19784@libero.it>
Content-Type: multipart/mixed; boundary="------------010105030002060203050101"
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] error to compile avetana
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010105030002060203050101
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,
I've been able to compile avetana without much problem, only that I
needed to patch it a bit in order to be able to compile it in my 64 bits
system.
I'm mailing you my patch.
Maybe you are missing something, make sure you make all the exports that
are required for building:
JDK_HOME
JDK_PLATFORM
BIN_DIR

JDK_PLATFORM should be just linux.
Then launch install.
Thanks,
Manuel
> Hi, i tried to compile avetanaBT-20070719.tgz but it return me the follow     error:
>
> g++ -shared -lbluetooth -I /opt/jdk1.6.0_03/include -I /opt/jdk1.6.0_03/include//opt/jdk1.6.0_03/include BlueZ.cpp -o /home/gianfranco/Desktop/Cartella/binaries/libavetanaBT.so 
> BlueZ.cpp: In function ‘int gen_dataseq_pdu(char*, const sdp_list_t*, uint8_t)’:
> BlueZ.cpp:198: error: invalid conversion from ‘uint8_t*’ to ‘char*’
> BlueZ.cpp: In function ‘jint Java_de_avetana_bluetooth_stack_BlueZ_getLinkQuality(JNIEnv*, _jclass*, _jstring*)’:
> BlueZ.cpp:407: error: ‘read_link_quality_rp’ was not declared in this scope
> BlueZ.cpp:407: error: expected `;' before ‘rp’
> BlueZ.cpp:456: error: ‘OCF_READ_LINK_QUALITY’ was not declared in this scope
> BlueZ.cpp:459: error: ‘rp’ was not declared in this scope
> BlueZ.cpp:460: error: ‘READ_LINK_QUALITY_RP_SIZE’ was not declared in this scope
> BlueZ.cpp: In function ‘jint Java_de_avetana_bluetooth_stack_BlueZ_updateService(JNIEnv*, _jclass*, _jobject*, jlong)’:
> BlueZ.cpp:1203: error: ‘sdp_gen_tid’ was not declared in this scope
> BlueZ.cpp: In function ‘jint Java_de_avetana_bluetooth_stack_BlueZ_createService(JNIEnv*, _jclass*, _jobject*)’:
> BlueZ.cpp:1385: error: ‘sdp_gen_tid’ was not declared in this scope
> BlueZ.cpp: In function ‘_jobject* my_sdp_service_attr_req(JNIEnv*, _jclass*, sdp_session_t*, uint32_t, sdp_attrreq_type_t, const sdp_list_t*)’:
> BlueZ.cpp:2139: error: ‘sdp_gen_tid’ was not declared in this scope
> BlueZ.cpp:2170: error: invalid conversion from ‘uint8_t*’ to ‘char*’
> BlueZ.cpp: In function ‘int my_sdp_service_search_attr_req(JNIEnv*, _jclass*, sdp_session_t*, const sdp_list_t*, sdp_attrreq_type_t, const sdp_list_t*, sdp_list_t**, sdp_list_t*, _jstring*, jint)’:
> BlueZ.cpp:2275: error: ‘sdp_gen_tid’ was not declared in this scope
> BlueZ.cpp:2313: error: invalid conversion from ‘uint8_t*’ to ‘char*’
> make[1]: *** [libavetanaBT.so] Error 1
> make[1]: Leaving directory `/home/gianfranco/Desktop/Cartella/c'
> make: *** [csource] Error 2
>
> Can you help me?
>
> Thanks
>
>
> -------------------------------------------------------------------------
> SF.Net email is sponsored by:
> Check out the new SourceForge.net Marketplace.
> It's the best place to buy or sell services
> for just about anything Open Source.
> http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>   


--------------010105030002060203050101
Content-Type: text/x-patch;
 name="avetana.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="avetana.patch"

diff -uprN ave/c/BlueZ.cpp aventana/c/BlueZ.cpp
--- ave/c/BlueZ.cpp	2007-07-19 11:21:14.000000000 -0300
+++ aventana/c/BlueZ.cpp	2007-12-18 10:07:27.000000000 -0300
@@ -257,7 +257,7 @@ static int gen_attridseq_pdu(char *dst, 
  * Throws a Java exception if an error occured. Depending on the erro, you will
  * surely have to call the method exit(1) after this excpetion is thrown
  */
-void throwException(JNIEnv *env, char *msg)
+void throwException(JNIEnv *env, const char *msg)
 {
 	/* Throw a BlueZException in Java, with the given message */
 	jclass exception_cls;
@@ -1230,7 +1230,7 @@ JNIEXPORT jint JNICALL Java_de_avetana_b
  * This jobject (a LocalServiceRecord if you are using the Avetana implementation) MUST implement a method
  * toByteArray().
  */
-JNIEXPORT jint JNICALL Java_de_avetana_bluetooth_stack_BlueZ_createService
+JNIEXPORT jlong JNICALL Java_de_avetana_bluetooth_stack_BlueZ_createService
 	(JNIEnv *env, jclass obj, jobject srecord) {
 
 	bdaddr_t interface;
@@ -1409,7 +1409,7 @@ JNIEXPORT jint JNICALL Java_de_avetana_b
 		srh->srHandle = handle;
 		
 		
-	return (jint)srh;
+	return (jlong)srh;
 	}
 	else return -1;
 }

diff -uprN ave/c/Makefile.in aventana/c/Makefile.in
--- ave/c/Makefile.in	2005-06-30 11:59:08.000000000 -0300
+++ aventana/c/Makefile.in	2007-12-18 10:26:15.000000000 -0300
@@ -69,4 +69,4 @@ de_avetana_bluetooth_stack_BlueZ.h: clea
 
 # Native language (C) library - libavetanaBT.so
 libavetanaBT.so: BlueZ.cpp de_avetana_bluetooth_stack_BlueZ.h 
-	$(CC) -shared -lbluetooth $(CFLAGS) BlueZ.cpp -o $(BIN_DIR)/libavetanaBT.so $(LDFLAGS)
+	$(CC) -fPIC -shared -lbluetooth $(CFLAGS) BlueZ.cpp -o $(BIN_DIR)/libavetanaBT.so $(LDFLAGS)
diff -uprN ave/de/avetana/bluetooth/stack/BlueZ.java aventana/de/avetana/bluetooth/stack/BlueZ.java
--- ave/de/avetana/bluetooth/stack/BlueZ.java	2007-05-17 17:33:21.000000000 -0300
+++ aventana/de/avetana/bluetooth/stack/BlueZ.java	2007-12-18 10:11:24.000000000 -0300
@@ -413,7 +413,7 @@ public class BlueZ
          * @return a positive integer is the process succeeds.
          * @throws BlueZException
          */
-        public static synchronized native int createService(LocalServiceRecord service) throws BlueZException;
+        public static synchronized native long createService(LocalServiceRecord service) throws BlueZException;
 
         /**
          * Updates an existing service record (the old <service record must be already stored in the BCC.)

--------------010105030002060203050101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------010105030002060203050101
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------010105030002060203050101--
