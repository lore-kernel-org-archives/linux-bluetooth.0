Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
References: <2992e569-78e1-ea64-52b5-a2df11a6c948@message-id.googlemail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 May 2017 10:03:36 +0300
Message-ID: <CABBYNZ+90yuLCDhEskujMK0jbqAM=VoGQYj6AQqz=Np8wyEhnw@mail.gmail.com>
Subject: Re: [BUG] unit/test-gatt failure uninitialized pointer(?)
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

On Fri, May 26, 2017 at 10:45 AM, Stefan Seyfried
<stefan.seyfried@googlemail.com> wrote:
> Hi all,
>
> in the Open Build Service packages for openSUSE are built in VMs without network connection. This leads to failure in "make check". Debugging found:
>
> /robustness/unkown-request - init
> /robustness/unkown-request - setup
> /robustness/unkown-request - setup complete
> /robustness/unkown-request - run
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0000555555598225 in timeout_cb (user_data=0x5555557c82f0) at src/shared/att.c:405
> 405             if (att->pending_req && att->pending_req->id == timeout->id) {
> (gdb) print att->pending_req->id
> Cannot access memory at address 0x4545454545454545
> (gdb) print att->pending_req
> $1 = (struct att_send_op *) 0x4545454545454545
> (gdb) print timeout->id
> $2 = 12
> (gdb) bt
> #0  0x0000555555598225 in timeout_cb (user_data=0x5555557c82f0) at src/shared/att.c:405
> #1  0x00005555555a499d in timeout_callback (user_data=<optimized out>) at src/shared/timeout-glib.c:34
> #2  0x00007ffff7b101d3 in ?? () from /usr/lib64/libglib-2.0.so.0
> #3  0x00007ffff7b0f75a in g_main_context_dispatch () from /usr/lib64/libglib-2.0.so.0
> #4  0x00007ffff7b0fb10 in ?? () from /usr/lib64/libglib-2.0.so.0
> #5  0x00007ffff7b0fe32 in g_main_loop_run () from /usr/lib64/libglib-2.0.so.0
> #6  0x0000555555597e84 in tester_run () at src/shared/tester.c:830
> #7  0x0000555555594a4c in main (argc=<optimized out>, argv=<optimized out>) at unit/test-gatt.c:4474
> (gdb)
>
> This started after I tried to update the package to bluez-5.45, it
> still happens with current bluez git master.

Are there any special tool you are running this? Or it is just gdb?
Under valgrind everything looks fine:

/robustness/unkown-request - init
/robustness/unkown-request - setup
/robustness/unkown-request - setup complete
/robustness/unkown-request - run
/robustness/unkown-request - test passed
/robustness/unkown-request - teardown
/robustness/unkown-request - teardown complete
/robustness/unkown-request - done


Test Summary
------------
/robustness/unkown-request                           Passed       0.070 seconds


> Hope this helps, I am now commenting out this test for now.
> --
> Stefan Seyfried
>
> "For a successful technology, reality must take precedence over
>  public relations, for nature cannot be fooled." -- Richard Feynman
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
