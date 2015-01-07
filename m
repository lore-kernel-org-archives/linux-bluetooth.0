Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Arthur Lambert <lambertarthur22@gmail.com>
Date: Wed, 7 Jan 2015 15:39:41 +0100
Message-ID: <CAGpqJgqKGKn49N=Vc1OFcZs-szNOhh-9C1zVZhEPkf9zLiRBsg@mail.gmail.com>
Subject: Valgrind issue on sdp
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am currently trying to implement a bluetooth server on linux to
communicate with an android mobile device. I am using rfcomm socket.

To be able to work with android I need to register a service using the
sdp feature (Android cannot use rc channel dirrectly or only in a
dirty way, need dynamic uuid though sdp).

I am currently able to communicate correctly between my linux and my
android. I was checking my code with valgrind and I get some memory
leak in sdp library. I have done some search about this subject but I
was not able to find a right answer.

Current implementation of my sdp (which come from :
http://people.csail.mit.edu/albert/bluez-intro/x604.html#bzi-sdp-register)
:

sdp_session_t* register_service(uint8_t rfcomm_channel)
{
uint32_t svc_uuid_int[] = {0, 0, 0, 0x1101};
const char *service_name = "tutu";
const char *service_dsc = "tata";
const char *service_prov = "titi";
uuid_t root_uuid, l2cap_uuid, rfcomm_uuid, svc_uuid, svc_class_uuid;
sdp_list_t *l2cap_list = 0,
*rfcomm_list = 0,
*root_list = 0,
*proto_list = 0,
*access_proto_list = 0,
*svc_class_list = 0,
*profile_list = 0;
sdp_data_t *channel = 0;
sdp_profile_desc_t profile;
sdp_record_t record = {0};
sdp_session_t *session = 0;

sdp_uuid128_create (&svc_uuid, &svc_uuid_int);
sdp_set_service_id (&record, svc_uuid);
sdp_uuid16_create (&svc_class_uuid, SERIAL_PORT_SVCLASS_ID);
svc_class_list = sdp_list_append (0, &svc_class_uuid);
sdp_set_service_classes (&record, svc_class_list);
sdp_uuid16_create (&profile.uuid, SERIAL_PORT_PROFILE_ID);
profile.version = 0x0100;
profile_list = sdp_list_append(0, &profile);
sdp_set_profile_descs(&record, profile_list);
sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
root_list = sdp_list_append(0, &root_uuid);

sdp_set_browse_groups( &record, root_list );
sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
l2cap_list = sdp_list_append( 0, &l2cap_uuid );
proto_list = sdp_list_append( 0, l2cap_list );
sdp_uuid16_create(&rfcomm_uuid, RFCOMM_UUID);
channel = sdp_data_alloc(SDP_UINT8, &rfcomm_channel);
rfcomm_list = sdp_list_append( 0, &rfcomm_uuid );
sdp_list_append( rfcomm_list, channel );
sdp_list_append( proto_list, rfcomm_list );
access_proto_list = sdp_list_append( 0, proto_list );
sdp_set_access_protos( &record, access_proto_list );
sdp_set_info_attr(&record, service_name, service_prov, service_dsc);
session = sdp_connect( BDADDR_ANY, BDADDR_LOCAL, 0 );
sdp_record_register(session, &record, 0);

sdp_data_free (channel);

sdp_list_free (l2cap_list, 0);
sdp_list_free (rfcomm_list, 0);
sdp_list_free (root_list, 0);
sdp_list_free (proto_list, 0);
sdp_list_free (access_proto_list, 0);
sdp_list_free (svc_class_list, 0);
sdp_list_free (profile_list, 0);

return session;
}

I used this function at the initialization of my bluetooth server.
When I closed it, I use sdp_close on the session.
Did I forget to call a specific function to clean all sdp structure ?

Valgrind give me this result :

==18792== 5 bytes in 1 blocks are indirectly lost in loss record 1 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44D54: sdp_data_alloc_with_length (sdp.c:433)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x4E452DD: sdp_set_info_attr (sdp.c:2231)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 13 bytes in 1 blocks are indirectly lost in loss record 2 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44D54: sdp_data_alloc_with_length (sdp.c:433)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x4E452C3: sdp_set_info_attr (sdp.c:2228)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 3 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E45288: sdp_attr_add_new (sdp.c:2199)
==18792==    by 0x4E46973: sdp_set_service_id (sdp.c:2430)
==18792==    by 0x401471: register_service (bluetooth_server.c:23)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 4 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E46DCD: sdp_set_uuidseq_attr (sdp.c:1995)
==18792==    by 0x40131C: sdp_set_service_classes (sdp_lib.h:205)
==18792==    by 0x4014B6: register_service (bluetooth_server.c:26)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 5 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E45F0B: sdp_pattern_add_uuid (sdp.c:3146)
==18792==    by 0x4E46CB3: sdp_pattern_add_uuidseq (sdp.c:3157)
==18792==    by 0x4E46DD8: sdp_set_uuidseq_attr (sdp.c:1996)
==18792==    by 0x40131C: sdp_set_service_classes (sdp_lib.h:205)
==18792==    by 0x4014B6: register_service (bluetooth_server.c:26)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 6 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E4439F: sdp_attr_add (sdp.c:591)
==18792==    by 0x4E46C5E: sdp_set_profile_descs (sdp.c:2537)
==18792==    by 0x4014FB: register_service (bluetooth_server.c:30)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 7 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E46DCD: sdp_set_uuidseq_attr (sdp.c:1995)
==18792==    by 0x401343: sdp_set_browse_groups (sdp_lib.h:227)
==18792==    by 0x401540: register_service (bluetooth_server.c:34)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 8 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E45F0B: sdp_pattern_add_uuid (sdp.c:3146)
==18792==    by 0x4E46CB3: sdp_pattern_add_uuidseq (sdp.c:3157)
==18792==    by 0x4E46DD8: sdp_set_uuidseq_attr (sdp.c:1996)
==18792==    by 0x401343: sdp_set_browse_groups (sdp_lib.h:227)
==18792==    by 0x401540: register_service (bluetooth_server.c:34)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 9 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E4439F: sdp_attr_add (sdp.c:591)
==18792==    by 0x4E46889: sdp_set_access_protos (sdp.c:2332)
==18792==    by 0x401637: register_service (bluetooth_server.c:44)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 10 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E45288: sdp_attr_add_new (sdp.c:2199)
==18792==    by 0x4E452C3: sdp_set_info_attr (sdp.c:2228)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 11 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E45288: sdp_attr_add_new (sdp.c:2199)
==18792==    by 0x4E452DD: sdp_set_info_attr (sdp.c:2231)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 16 bytes in 1 blocks are indirectly lost in loss record 12 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E45288: sdp_attr_add_new (sdp.c:2199)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 20 bytes in 1 blocks are indirectly lost in loss record 13 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E456F2: sdp_uuid_to_uuid128 (sdp.c:2683)
==18792==    by 0x4E45EBE: sdp_pattern_add_uuid (sdp.c:3140)
==18792==    by 0x4E46980: sdp_set_service_id (sdp.c:2434)
==18792==    by 0x401471: register_service (bluetooth_server.c:23)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 20 bytes in 1 blocks are indirectly lost in loss record 14 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E456F2: sdp_uuid_to_uuid128 (sdp.c:2683)
==18792==    by 0x4E45EBE: sdp_pattern_add_uuid (sdp.c:3140)
==18792==    by 0x4E46CB3: sdp_pattern_add_uuidseq (sdp.c:3157)
==18792==    by 0x4E46DD8: sdp_set_uuidseq_attr (sdp.c:1996)
==18792==    by 0x40131C: sdp_set_service_classes (sdp_lib.h:205)
==18792==    by 0x4014B6: register_service (bluetooth_server.c:26)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 20 bytes in 1 blocks are indirectly lost in loss record 15 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E456F2: sdp_uuid_to_uuid128 (sdp.c:2683)
==18792==    by 0x4E45EBE: sdp_pattern_add_uuid (sdp.c:3140)
==18792==    by 0x4E46CB3: sdp_pattern_add_uuidseq (sdp.c:3157)
==18792==    by 0x4E46DD8: sdp_set_uuidseq_attr (sdp.c:1996)
==18792==    by 0x401343: sdp_set_browse_groups (sdp_lib.h:227)
==18792==    by 0x401540: register_service (bluetooth_server.c:34)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 25 bytes in 1 blocks are indirectly lost in loss record 16 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44D54: sdp_data_alloc_with_length (sdp.c:433)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 32 bytes in 2 blocks are indirectly lost in loss record 17 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E45F0B: sdp_pattern_add_uuid (sdp.c:3146)
==18792==    by 0x4E467AC: access_proto_to_dataseq (sdp.c:2297)
==18792==    by 0x4E46863: sdp_set_access_protos (sdp.c:2328)
==18792==    by 0x401637: register_service (bluetooth_server.c:44)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 40 bytes in 2 blocks are indirectly lost in loss record 18 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E456F2: sdp_uuid_to_uuid128 (sdp.c:2683)
==18792==    by 0x4E45EBE: sdp_pattern_add_uuid (sdp.c:3140)
==18792==    by 0x4E467AC: access_proto_to_dataseq (sdp.c:2297)
==18792==    by 0x4E46863: sdp_set_access_protos (sdp.c:2328)
==18792==    by 0x401637: register_service (bluetooth_server.c:44)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 19 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x4E46973: sdp_set_service_id (sdp.c:2430)
==18792==    by 0x401471: register_service (bluetooth_server.c:23)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 20 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E44F59: sdp_seq_alloc (sdp.c:550)
==18792==    by 0x4E46DBD: sdp_set_uuidseq_attr (sdp.c:1994)
==18792==    by 0x40131C: sdp_set_service_classes (sdp_lib.h:205)
==18792==    by 0x4014B6: register_service (bluetooth_server.c:26)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 21 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E46DBD: sdp_set_uuidseq_attr (sdp.c:1994)
==18792==    by 0x40131C: sdp_set_service_classes (sdp_lib.h:205)
==18792==    by 0x4014B6: register_service (bluetooth_server.c:26)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 22 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E46B67: sdp_set_profile_descs (sdp.c:2527)
==18792==    by 0x4014FB: register_service (bluetooth_server.c:30)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 23 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E46C4C: sdp_set_profile_descs (sdp.c:2536)
==18792==    by 0x4014FB: register_service (bluetooth_server.c:30)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 24 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E44F59: sdp_seq_alloc (sdp.c:550)
==18792==    by 0x4E46DBD: sdp_set_uuidseq_attr (sdp.c:1994)
==18792==    by 0x401343: sdp_set_browse_groups (sdp_lib.h:227)
==18792==    by 0x401540: register_service (bluetooth_server.c:34)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 25 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E46DBD: sdp_set_uuidseq_attr (sdp.c:1994)
==18792==    by 0x401343: sdp_set_browse_groups (sdp_lib.h:227)
==18792==    by 0x401540: register_service (bluetooth_server.c:34)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 26 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E467D7: access_proto_to_dataseq (sdp.c:2300)
==18792==    by 0x4E46863: sdp_set_access_protos (sdp.c:2328)
==18792==    by 0x401637: register_service (bluetooth_server.c:44)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 27 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x4E452C3: sdp_set_info_attr (sdp.c:2228)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 28 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x4E452DD: sdp_set_info_attr (sdp.c:2231)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 29 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E45275: sdp_attr_add_new (sdp.c:2197)
==18792==    by 0x401658: register_service (bluetooth_server.c:45)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 48 bytes in 1 blocks are indirectly lost in loss record 30 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E476EC: sdp_device_record_register (sdp.c:2925)
==18792==    by 0x4E47761: sdp_record_register (sdp.c:2935)
==18792==    by 0x4016EC: register_service (bluetooth_server.c:47)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 96 bytes in 2 blocks are indirectly lost in loss record 31 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E44F59: sdp_seq_alloc (sdp.c:550)
==18792==    by 0x4E46B67: sdp_set_profile_descs (sdp.c:2527)
==18792==    by 0x4014FB: register_service (bluetooth_server.c:30)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 96 bytes in 2 blocks are indirectly lost in loss record 32 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E46784: access_proto_to_dataseq (sdp.c:2292)
==18792==    by 0x4E46863: sdp_set_access_protos (sdp.c:2328)
==18792==    by 0x401637: register_service (bluetooth_server.c:44)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 144 bytes in 3 blocks are indirectly lost in loss record 33 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E44BFE: sdp_data_alloc_with_length (sdp.c:357)
==18792==    by 0x4E44F59: sdp_seq_alloc (sdp.c:550)
==18792==    by 0x4E46784: access_proto_to_dataseq (sdp.c:2292)
==18792==    by 0x4E46863: sdp_set_access_protos (sdp.c:2328)
==18792==    by 0x401637: register_service (bluetooth_server.c:44)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 180 (16 direct, 164 indirect) bytes in 1 blocks are
definitely lost in loss record 34 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E45F0B: sdp_pattern_add_uuid (sdp.c:3146)
==18792==    by 0x4E46980: sdp_set_service_id (sdp.c:2434)
==18792==    by 0x401471: register_service (bluetooth_server.c:23)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== 1,099 (16 direct, 1,083 indirect) bytes in 1 blocks are
definitely lost in loss record 35 of 35
==18792==    at 0x4C2AB80: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18792==    by 0x4E442F0: sdp_list_insert_sorted (sdp.c:1788)
==18792==    by 0x4E44431: sdp_attr_replace (sdp.c:949)
==18792==    by 0x4E476FF: sdp_device_record_register (sdp.c:2927)
==18792==    by 0x4E47761: sdp_record_register (sdp.c:2935)
==18792==    by 0x4016EC: register_service (bluetooth_server.c:47)
==18792==    by 0x4018A5: init_bluetooth_server (bluetooth_server.c:96)
==18792==    by 0x4012F0: main (test_bluetooth_server.c:8)
==18792==
==18792== LEAK SUMMARY:
==18792==    definitely lost: 32 bytes in 2 blocks
==18792==    indirectly lost: 1,247 bytes in 39 blocks
==18792==      possibly lost: 0 bytes in 0 blocks
==18792==    still reachable: 0 bytes in 0 blocks
==18792==         suppressed: 0 bytes in 0 blocks


Thanks,
Arthur
