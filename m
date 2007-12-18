Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Dec 2007 09:55:15 +0100
Message-Id: <JT8M43$561AFF24392062823768CC682BF19784@libero.it>
MIME-Version: 1.0
From: "russogia4@libero.it" <russogia4@libero.it>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] error to compile avetana
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi, i tried to compile avetanaBT-20070719.tgz but it return me the follow  =
   error:

g++ -shared -lbluetooth -I /opt/jdk1.6.0_03/include -I /opt/jdk1.6.0_03/inc=
lude//opt/jdk1.6.0_03/include BlueZ.cpp -o /home/gianfranco/Desktop/Cartell=
a/binaries/libavetanaBT.so =

BlueZ.cpp: In function =91int gen_dataseq_pdu(char*, const sdp_list_t*, uin=
t8_t)=92:
BlueZ.cpp:198: error: invalid conversion from =91uint8_t*=92 to =91char*=92
BlueZ.cpp: In function =91jint Java_de_avetana_bluetooth_stack_BlueZ_getLin=
kQuality(JNIEnv*, _jclass*, _jstring*)=92:
BlueZ.cpp:407: error: =91read_link_quality_rp=92 was not declared in this s=
cope
BlueZ.cpp:407: error: expected `;' before =91rp=92
BlueZ.cpp:456: error: =91OCF_READ_LINK_QUALITY=92 was not declared in this =
scope
BlueZ.cpp:459: error: =91rp=92 was not declared in this scope
BlueZ.cpp:460: error: =91READ_LINK_QUALITY_RP_SIZE=92 was not declared in t=
his scope
BlueZ.cpp: In function =91jint Java_de_avetana_bluetooth_stack_BlueZ_update=
Service(JNIEnv*, _jclass*, _jobject*, jlong)=92:
BlueZ.cpp:1203: error: =91sdp_gen_tid=92 was not declared in this scope
BlueZ.cpp: In function =91jint Java_de_avetana_bluetooth_stack_BlueZ_create=
Service(JNIEnv*, _jclass*, _jobject*)=92:
BlueZ.cpp:1385: error: =91sdp_gen_tid=92 was not declared in this scope
BlueZ.cpp: In function =91_jobject* my_sdp_service_attr_req(JNIEnv*, _jclas=
s*, sdp_session_t*, uint32_t, sdp_attrreq_type_t, const sdp_list_t*)=92:
BlueZ.cpp:2139: error: =91sdp_gen_tid=92 was not declared in this scope
BlueZ.cpp:2170: error: invalid conversion from =91uint8_t*=92 to =91char*=
=92
BlueZ.cpp: In function =91int my_sdp_service_search_attr_req(JNIEnv*, _jcla=
ss*, sdp_session_t*, const sdp_list_t*, sdp_attrreq_type_t, const sdp_list_=
t*, sdp_list_t**, sdp_list_t*, _jstring*, jint)=92:
BlueZ.cpp:2275: error: =91sdp_gen_tid=92 was not declared in this scope
BlueZ.cpp:2313: error: invalid conversion from =91uint8_t*=92 to =91char*=
=92
make[1]: *** [libavetanaBT.so] Error 1
make[1]: Leaving directory `/home/gianfranco/Desktop/Cartella/c'
make: *** [csource] Error 2

Can you help me?

Thanks


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
