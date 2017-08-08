Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: Bluez can crash with SIGSEGV while registering an LE
 advertisement
From: Kai Ruhnau <kai.ruhnau@target-sg.com>
To: linux-bluetooth@vger.kernel.org, dsusch@hotmail.com
References: <fec372b2-6ef9-8273-ebe6-ea25083ee4b9@target-sg.com>
Message-ID: <bf57df88-8de7-77fa-cc2e-ff7b43257f01@target-sg.com>
Date: Tue, 8 Aug 2017 11:56:34 +0200
MIME-Version: 1.0
In-Reply-To: <fec372b2-6ef9-8273-ebe6-ea25083ee4b9@target-sg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 07.08.2017 15:50, Kai Ruhnau wrote:
> [This sender failed our fraud detection checks and may not be who they
> appear to be. Learn about spoofing at http://aka.ms/LearnAboutSpoofing]
>
> I'm able to crash Bluez 4.43 with SIGSEGV. The Bluez code hasn't changed
> in that area since, so it should (not) work in more recent versions as
> well. The code that reproduces the problem on my embedded platform is
> here:
> https://github.com/Tragetaschen/bluez-advertisement-registration-sigsegv
>
> The problem is that while calling
> org.bluez.LEAdvertisingManager1.RegisterAdvertisement, Bluez sends two
> method calls to the given object path:
>
> - org.freedesktop.DBus.Properties.GetAll
>
> - org.freedesktop.DBus.ObjectManager.GetManagedObjects
>
> When these two methods are replied to in order (GetAll then
> GetManagedObjects), everything works as expected. When the order is
> reversed, Bluez sends an error for the RegisterAdvertisement with
> "Failed to parse advertisement" after the GetManagedObjects returns and
> then dies by a SIGSEGV when GetAll returns.
>
> My DbusCore implementation uses a thread pool to dispatch incoming
> method calls and doesn't have the necessary ordering requirements.

As per suggestion on IRC, I've run bluetoothd with valgrind: here's the
output from the crash (it begins after the "uninialised bytes(s)" message):

=3D=3D326=3D=3D Memcheck, a memory error detector
=3D=3D326=3D=3D Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et=
 al.
=3D=3D326=3D=3D Using Valgrind-3.12.0 and LibVEX; rerun with -h for copyrig=
ht info
=3D=3D326=3D=3D Command: /usr/libexec/bluetooth/bluetoothd -E
=3D=3D326=3D=3D
=3D=3D326=3D=3D Syscall param socketcall.bind(my_addr.rc_bdaddr) points to
uninitialised byte(s)
=3D=3D326=3D=3D    at 0x4AAE9EC: bind (syscall-template.S:84)
=3D=3D326=3D=3D    by 0x53D5B: logging_open (log.c:76)
=3D=3D326=3D=3D    by 0x53D5B: __btd_log_init (log.c:314)
=3D=3D326=3D=3D    by 0x18FAB: main (main.c:631)
=3D=3D326=3D=3D  Address 0xbdcddb36 is on thread 1's stack
=3D=3D326=3D=3D  in frame #1, created by __btd_log_init (log.c:309)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x61578: parse_advertising_type (advertising.c:175)
=3D=3D326=3D=3D    by 0x61578: parse_advertisement (advertising.c:531)
=3D=3D326=3D=3D    by 0x61578: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d0 is 16 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 1
=3D=3D326=3D=3D    at 0x617BC: parse_advertising_type (advertising.c:189)
=3D=3D326=3D=3D    by 0x617BC: parse_advertisement (advertising.c:531)
=3D=3D326=3D=3D    by 0x617BC: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d8 is 24 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x61638: parse_advertising_service_uuids (advertising=
.c:201)
=3D=3D326=3D=3D    by 0x61638: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61638: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d0 is 16 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x6163C: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x6163C: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983dc is 28 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x99918: bt_ad_clear_service_uuid (ad.c:409)
=3D=3D326=3D=3D    by 0x617E7: parse_advertising_service_uuids (advertising=
.c:209)
=3D=3D326=3D=3D    by 0x617E7: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x617E7: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd94 is 4 bytes inside a block of size 20 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96EA8: queue_remove_all (queue.c:324)
=3D=3D326=3D=3D    by 0x617E7: parse_advertising_service_uuids (advertising=
.c:209)
=3D=3D326=3D=3D    by 0x617E7: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x617E7: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96F10: queue_remove_all (queue.c:341)
=3D=3D326=3D=3D    by 0x617E7: parse_advertising_service_uuids (advertising=
.c:209)
=3D=3D326=3D=3D    by 0x617E7: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x617E7: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96F14: queue_remove_all (queue.c:342)
=3D=3D326=3D=3D    by 0x617E7: parse_advertising_service_uuids (advertising=
.c:209)
=3D=3D326=3D=3D    by 0x617E7: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x617E7: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bde0 is 8 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96F18: queue_remove_all (queue.c:343)
=3D=3D326=3D=3D    by 0x617E7: parse_advertising_service_uuids (advertising=
.c:209)
=3D=3D326=3D=3D    by 0x617E7: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x617E7: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bde4 is 12 bytes inside a block of size 16 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x998A4: bt_ad_add_service_uuid (ad.c:393)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd94 is 4 bytes inside a block of size 20 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96AD4: queue_push_tail (queue.c:97)
=3D=3D326=3D=3D    by 0x993B7: queue_add_uuid (ad.c:355)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bde0 is 8 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96AE0: queue_push_tail (queue.c:102)
=3D=3D326=3D=3D    by 0x993B7: queue_add_uuid (ad.c:355)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96AE4: queue_push_tail (queue.c:100)
=3D=3D326=3D=3D    by 0x993B7: queue_add_uuid (ad.c:355)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bde0 is 8 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96AEC: queue_push_tail (queue.c:105)
=3D=3D326=3D=3D    by 0x993B7: queue_add_uuid (ad.c:355)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bde4 is 12 bytes inside a block of size 16 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96AF0: queue_push_tail (queue.c:103)
=3D=3D326=3D=3D    by 0x993B7: queue_add_uuid (ad.c:355)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96AFC: queue_push_tail (queue.c:105)
=3D=3D326=3D=3D    by 0x993B7: queue_add_uuid (ad.c:355)
=3D=3D326=3D=3D    by 0x61813: parse_advertising_service_uuids (advertising=
.c:222)
=3D=3D326=3D=3D    by 0x61813: parse_advertisement (advertising.c:536)
=3D=3D326=3D=3D    by 0x61813: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bde4 is 12 bytes inside a block of size 16 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x61658: parse_advertising_solicit_uuids (advertising=
.c:240)
=3D=3D326=3D=3D    by 0x61658: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x61658: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d0 is 16 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x6165C: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x6165C: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983dc is 28 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x99B94: bt_ad_clear_solicit_uuid (ad.c:545)
=3D=3D326=3D=3D    by 0x6189B: parse_advertising_solicit_uuids (advertising=
.c:248)
=3D=3D326=3D=3D    by 0x6189B: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x6189B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd9c is 12 bytes inside a block of size 20 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96EA8: queue_remove_all (queue.c:324)
=3D=3D326=3D=3D    by 0x6189B: parse_advertising_solicit_uuids (advertising=
.c:248)
=3D=3D326=3D=3D    by 0x6189B: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x6189B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be5c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96F10: queue_remove_all (queue.c:341)
=3D=3D326=3D=3D    by 0x6189B: parse_advertising_solicit_uuids (advertising=
.c:248)
=3D=3D326=3D=3D    by 0x6189B: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x6189B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be5c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96F14: queue_remove_all (queue.c:342)
=3D=3D326=3D=3D    by 0x6189B: parse_advertising_solicit_uuids (advertising=
.c:248)
=3D=3D326=3D=3D    by 0x6189B: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x6189B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be60 is 8 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96F18: queue_remove_all (queue.c:343)
=3D=3D326=3D=3D    by 0x6189B: parse_advertising_solicit_uuids (advertising=
.c:248)
=3D=3D326=3D=3D    by 0x6189B: parse_advertisement (advertising.c:541)
=3D=3D326=3D=3D    by 0x6189B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be64 is 12 bytes inside a block of size 16 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x6166C: parse_advertisement (advertising.c:546)
=3D=3D326=3D=3D    by 0x6166C: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983dc is 28 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x61670: parse_advertisement (advertising.c:546)
=3D=3D326=3D=3D    by 0x61670: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d0 is 16 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x616D0: parse_advertisement (advertising.c:551)
=3D=3D326=3D=3D    by 0x616D0: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983dc is 28 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x616D4: parse_advertisement (advertising.c:551)
=3D=3D326=3D=3D    by 0x616D4: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d0 is 16 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x616F0: parse_advertising_include_tx_power
(advertising.c:391)
=3D=3D326=3D=3D    by 0x616F0: parse_advertisement (advertising.c:556)
=3D=3D326=3D=3D    by 0x616F0: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d0 is 16 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 1
=3D=3D326=3D=3D    at 0x61A54: parse_advertising_include_tx_power
(advertising.c:399)
=3D=3D326=3D=3D    by 0x61A54: parse_advertisement (advertising.c:556)
=3D=3D326=3D=3D    by 0x61A54: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d9 is 25 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 1
=3D=3D326=3D=3D    at 0x61714: refresh_advertisement (advertising.c:479)
=3D=3D326=3D=3D    by 0x61714: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x61714: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d8 is 24 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 1
=3D=3D326=3D=3D    at 0x6171C: refresh_advertisement (advertising.c:482)
=3D=3D326=3D=3D    by 0x6171C: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6171C: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983d9 is 25 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x61720: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x61720: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x61720: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983dc is 28 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x995C0: calculate_length (ad.c:190)
=3D=3D326=3D=3D    by 0x995C0: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd94 is 4 bytes inside a block of size 20 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x99227: uuid_list_length (ad.c:121)
=3D=3D326=3D=3D    by 0x995CB: calculate_length (ad.c:190)
=3D=3D326=3D=3D    by 0x995CB: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x995D0: calculate_length (ad.c:192)
=3D=3D326=3D=3D    by 0x995D0: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd9c is 12 bytes inside a block of size 20 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x99227: uuid_list_length (ad.c:121)
=3D=3D326=3D=3D    by 0x995D7: calculate_length (ad.c:192)
=3D=3D326=3D=3D    by 0x995D7: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be5c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x995DC: mfg_data_length (ad.c:155)
=3D=3D326=3D=3D    by 0x995DC: calculate_length (ad.c:194)
=3D=3D326=3D=3D    by 0x995DC: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd98 is 8 bytes inside a block of size 20 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x995E3: mfg_data_length (ad.c:155)
=3D=3D326=3D=3D    by 0x995E3: calculate_length (ad.c:194)
=3D=3D326=3D=3D    by 0x995E3: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be1c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x9960C: uuid_data_length (ad.c:173)
=3D=3D326=3D=3D    by 0x9960C: calculate_length (ad.c:196)
=3D=3D326=3D=3D    by 0x9960C: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bda0 is 16 bytes inside a block of size 20 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x99617: uuid_data_length (ad.c:173)
=3D=3D326=3D=3D    by 0x99617: calculate_length (ad.c:196)
=3D=3D326=3D=3D    by 0x99617: bt_ad_generate (ad.c:324)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be9c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x99668: bt_ad_generate (ad.c:333)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd94 is 4 bytes inside a block of size 20 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x992AB: serialize_uuids (ad.c:205)
=3D=3D326=3D=3D    by 0x99687: serialize_service_uuids (ad.c:237)
=3D=3D326=3D=3D    by 0x99687: bt_ad_generate (ad.c:333)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x992AB: serialize_uuids (ad.c:205)
=3D=3D326=3D=3D    by 0x9969F: serialize_service_uuids (ad.c:239)
=3D=3D326=3D=3D    by 0x9969F: bt_ad_generate (ad.c:333)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x992AB: serialize_uuids (ad.c:205)
=3D=3D326=3D=3D    by 0x996B7: serialize_service_uuids (ad.c:241)
=3D=3D326=3D=3D    by 0x996B7: bt_ad_generate (ad.c:333)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bddc is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x996B8: bt_ad_generate (ad.c:335)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd9c is 12 bytes inside a block of size 20 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x992AB: serialize_uuids (ad.c:205)
=3D=3D326=3D=3D    by 0x996D3: serialize_solicit_uuids (ad.c:247)
=3D=3D326=3D=3D    by 0x996D3: bt_ad_generate (ad.c:335)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be5c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x992AB: serialize_uuids (ad.c:205)
=3D=3D326=3D=3D    by 0x996EB: serialize_solicit_uuids (ad.c:249)
=3D=3D326=3D=3D    by 0x996EB: bt_ad_generate (ad.c:335)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be5c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x992AB: serialize_uuids (ad.c:205)
=3D=3D326=3D=3D    by 0x99703: serialize_solicit_uuids (ad.c:251)
=3D=3D326=3D=3D    by 0x99703: bt_ad_generate (ad.c:335)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be5c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x99704: serialize_manuf_data (ad.c:257)
=3D=3D326=3D=3D    by 0x99704: bt_ad_generate (ad.c:337)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bd98 is 8 bytes inside a block of size 20 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x9970B: serialize_manuf_data (ad.c:257)
=3D=3D326=3D=3D    by 0x9970B: bt_ad_generate (ad.c:337)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be1c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x9977C: serialize_service_data (ad.c:281)
=3D=3D326=3D=3D    by 0x9977C: bt_ad_generate (ad.c:339)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9bda0 is 16 bytes inside a block of size 20 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x96F84: queue_get_entries (queue.c:366)
=3D=3D326=3D=3D    by 0x99783: serialize_service_data (ad.c:281)
=3D=3D326=3D=3D    by 0x99783: bt_ad_generate (ad.c:339)
=3D=3D326=3D=3D    by 0x6173B: refresh_advertisement (advertising.c:485)
=3D=3D326=3D=3D    by 0x6173B: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x6173B: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d9be9c is 4 bytes inside a block of size 16 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x61748: calc_max_adv_len (advertising.c:450)
=3D=3D326=3D=3D    by 0x61748: refresh_advertisement (advertising.c:487)
=3D=3D326=3D=3D    by 0x61748: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x61748: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983c0 is 0 bytes inside a block of size 36 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 1
=3D=3D326=3D=3D    at 0x61988: refresh_advertisement (advertising.c:508)
=3D=3D326=3D=3D    by 0x61988: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x61988: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983e0 is 32 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x619B0: refresh_advertisement (advertising.c:514)
=3D=3D326=3D=3D    by 0x619B0: parse_advertisement (advertising.c:562)
=3D=3D326=3D=3D    by 0x619B0: advertisement_proxy_added (advertising.c:573=
)
=3D=3D326=3D=3D    by 0x9627B: get_all_properties_reply (client.c:303)
=3D=3D326=3D=3D    by 0x4974867: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D  Address 0x4d983c0 is 0 bytes inside a block of size 36 fre=
e'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x6122C: add_advertising_callback (advertising.c:440)
=3D=3D326=3D=3D    by 0x976EF: request_complete (mgmt.c:261)
=3D=3D326=3D=3D    by 0x980C3: can_read_data (mgmt.c:353)
=3D=3D326=3D=3D    by 0xA3823: watch_callback (io-glib.c:170)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_dispatch (gmain.c:3203)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_context_dispatch (gmain.c:3856)
=3D=3D326=3D=3D    by 0x48AA2CF: g_main_context_iterate.isra.29 (gmain.c:39=
29)
=3D=3D326=3D=3D    by 0x48AA62F: g_main_loop_run (gmain.c:4125)
=3D=3D326=3D=3D    by 0x195E3: main (main.c:708)
=3D=3D326=3D=3D  Address 0x4d983cc is 12 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 1
=3D=3D326=3D=3D    at 0x61230: add_advertising_callback (advertising.c:438)
=3D=3D326=3D=3D    by 0x976EF: request_complete (mgmt.c:261)
=3D=3D326=3D=3D    by 0x980C3: can_read_data (mgmt.c:353)
=3D=3D326=3D=3D    by 0xA3823: watch_callback (io-glib.c:170)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_dispatch (gmain.c:3203)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_context_dispatch (gmain.c:3856)
=3D=3D326=3D=3D    by 0x48AA2CF: g_main_context_iterate.isra.29 (gmain.c:39=
29)
=3D=3D326=3D=3D    by 0x48AA62F: g_main_loop_run (gmain.c:4125)
=3D=3D326=3D=3D    by 0x195E3: main (main.c:708)
=3D=3D326=3D=3D  Address 0x4d983e0 is 32 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96600: g_dbus_client_set_disconnect_watch (client.c=
:1352)
=3D=3D326=3D=3D    by 0x61237: add_advertising_callback (advertising.c:440)
=3D=3D326=3D=3D    by 0x976EF: request_complete (mgmt.c:261)
=3D=3D326=3D=3D    by 0x980C3: can_read_data (mgmt.c:353)
=3D=3D326=3D=3D    by 0xA3823: watch_callback (io-glib.c:170)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_dispatch (gmain.c:3203)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_context_dispatch (gmain.c:3856)
=3D=3D326=3D=3D    by 0x48AA2CF: g_main_context_iterate.isra.29 (gmain.c:39=
29)
=3D=3D326=3D=3D    by 0x48AA62F: g_main_loop_run (gmain.c:4125)
=3D=3D326=3D=3D    by 0x195E3: main (main.c:708)
=3D=3D326=3D=3D  Address 0x4d9844c is 52 bytes inside a block of size 100 f=
ree'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x4849048: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid write of size 4
=3D=3D326=3D=3D    at 0x96604: g_dbus_client_set_disconnect_watch (client.c=
:1353)
=3D=3D326=3D=3D    by 0x61237: add_advertising_callback (advertising.c:440)
=3D=3D326=3D=3D    by 0x976EF: request_complete (mgmt.c:261)
=3D=3D326=3D=3D    by 0x980C3: can_read_data (mgmt.c:353)
=3D=3D326=3D=3D    by 0xA3823: watch_callback (io-glib.c:170)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_dispatch (gmain.c:3203)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_context_dispatch (gmain.c:3856)
=3D=3D326=3D=3D    by 0x48AA2CF: g_main_context_iterate.isra.29 (gmain.c:39=
29)
=3D=3D326=3D=3D    by 0x48AA62F: g_main_loop_run (gmain.c:4125)
=3D=3D326=3D=3D    by 0x195E3: main (main.c:708)
=3D=3D326=3D=3D  Address 0x4d98454 is 60 bytes inside a block of size 100 f=
ree'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x4849048: calloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
=3D=3D326=3D=3D Invalid read of size 4
=3D=3D326=3D=3D    at 0x6124C: add_adverting_complete (advertising.c:417)
=3D=3D326=3D=3D    by 0x6124C: add_advertising_callback (advertising.c:445)
=3D=3D326=3D=3D    by 0x976EF: request_complete (mgmt.c:261)
=3D=3D326=3D=3D    by 0x980C3: can_read_data (mgmt.c:353)
=3D=3D326=3D=3D    by 0xA3823: watch_callback (io-glib.c:170)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_dispatch (gmain.c:3203)
=3D=3D326=3D=3D    by 0x48A9F37: g_main_context_dispatch (gmain.c:3856)
=3D=3D326=3D=3D    by 0x48AA2CF: g_main_context_iterate.isra.29 (gmain.c:39=
29)
=3D=3D326=3D=3D    by 0x48AA62F: g_main_loop_run (gmain.c:4125)
=3D=3D326=3D=3D    by 0x195E3: main (main.c:708)
=3D=3D326=3D=3D  Address 0x4d983d4 is 20 bytes inside a block of size 36 fr=
ee'd
=3D=3D326=3D=3D    at 0x4847F30: free (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D  Block was alloc'd at
=3D=3D326=3D=3D    at 0x48468F0: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-arm-linux.so)
=3D=3D326=3D=3D
process 326: arguments to dbus_message_new_method_return() were
incorrect, assertion "method_call !=3D NULL" failed in file
../../dbus-1.10.14/dbus/dbus-message.c line 1405.
This is normally a bug in some application using the D-Bus library.
   D-Bus not built with -rdynamic so unable to print a backtrace
=3D=3D326=3D=3D
=3D=3D326=3D=3D Process terminating with default action of signal 6 (SIGABR=
T):
dumping core
=3D=3D326=3D=3D    at 0x4A092C0: raise (raise.c:51)
=3D=3D326=3D=3D    by 0x4A0A61F: abort (abort.c:89)
=3D=3D326=3D=3D    by 0x499B34F: ??? (in /usr/lib/libdbus-1.so.3.14.9)
=3D=3D326=3D=3D
=3D=3D326=3D=3D HEAP SUMMARY:
=3D=3D326=3D=3D     in use at exit: 47,927 bytes in 912 blocks
=3D=3D326=3D=3D   total heap usage: 4,460 allocs, 3,548 frees, 308,248 byte=
s
allocated
=3D=3D326=3D=3D
=3D=3D326=3D=3D LEAK SUMMARY:
=3D=3D326=3D=3D    definitely lost: 8 bytes in 1 blocks
=3D=3D326=3D=3D    indirectly lost: 20 bytes in 1 blocks
=3D=3D326=3D=3D      possibly lost: 0 bytes in 0 blocks
=3D=3D326=3D=3D    still reachable: 47,899 bytes in 910 blocks
=3D=3D326=3D=3D         suppressed: 0 bytes in 0 blocks
=3D=3D326=3D=3D Rerun with --leak-check=3Dfull to see details of leaked mem=
ory
=3D=3D326=3D=3D
=3D=3D326=3D=3D For counts of detected and suppressed errors, rerun with: -=
v
=3D=3D326=3D=3D Use --track-origins=3Dyes to see where uninitialised values=
 come from
=3D=3D326=3D=3D ERROR SUMMARY: 61 errors from 61 contexts (suppressed: 0 fr=
om 0)
Aborted (core dumped)

--
Kai Ruhnau
Software Manager
T:+49 202 769302 19

Target Systemelektronik GmbH & Co. KG
Heinz-Fangman-Stra=C3=9Fe 4
42287 Wuppertal

Amtsgericht Wuppertal HRA 23898
Pers=C3=B6nlich haftende Gesellschafterin
Target Systemelektronik Beteiligungs GmbH
Heinz-Fangman-Stra=C3=9Fe 4, 42287 Wuppertal
Amtsgericht Wuppertal HRB 25346
Gesch=C3=A4ftsf=C3=BChrer: J=C3=BCrgen Stein
--
