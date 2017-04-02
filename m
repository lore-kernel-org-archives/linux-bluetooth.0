Return-Path: <fengguang.wu@intel.com>
Date: Sun, 2 Apr 2017 11:39:45 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Harry Morris <harrymorris12@gmail.com>
Cc: kbuild-all@01.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [bluetooth-next:master 25/36]
 drivers/clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has
 incomplete type
Message-ID: <201704021142.rhF9MvD6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
List-ID: <linux-bluetooth.vger.kernel.org>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   733db4ccec579e027f54011573a2304c205e7b3d
commit: 3c599b249f3c6090e886bae8e7258bb6176205ef [25/36] ieee802154: Add CA8210 IEEE 802.15.4 device driver
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 3c599b249f3c6090e886bae8e7258bb6176205ef
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has incomplete type
     struct clocksource clksrc;
                        ^~~~~~
>> drivers/clocksource/timer-sun5i.c:60:28: error: field 'clkevt' has incomplete type
     struct clock_event_device clkevt;
                               ^~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers/clocksource/timer-sun5i.c:13:
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_shutdown':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_oneshot':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_periodic':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_next_event':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clksrc_read':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'cs')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clksrc':
>> drivers/clocksource/timer-sun5i.c:171:3: error: implicit declaration of function 'clocksource_unregister' [-Werror=implicit-function-declaration]
      clocksource_unregister(&cs->clksrc);
      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:175:3: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
      clocksource_register_hz(&cs->clksrc, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_setup_clocksource':
>> drivers/clocksource/timer-sun5i.c:223:20: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     cs->clksrc.mask = CLOCKSOURCE_MASK(32);
                       ^~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:224:21: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:224:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clkevt':
>> drivers/clocksource/timer-sun5i.c:251:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ce->clkevt, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_setup_clockevent':
>> drivers/clocksource/timer-sun5i.c:291:24: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                           ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:291:50: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:305:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ce->clkevt, rate,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: At top level:
>> drivers/clocksource/timer-sun5i.c:361:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:363:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:326:19: warning: 'sun5i_timer_init' defined but not used [-Wunused-function]
    static int __init sun5i_timer_init(struct device_node *node)
                      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> drivers/clocksource/cadence_ttc_timer.c:92:21: error: field 'cs' has incomplete type
     struct clocksource cs;
                        ^~
>> drivers/clocksource/cadence_ttc_timer.c:100:28: error: field 'ce' has incomplete type
     struct clock_event_device ce;
                               ^~
   In file included from include/linux/clk.h:16:0,
                    from drivers/clocksource/cadence_ttc_timer.c:18:
   drivers/clocksource/cadence_ttc_timer.c: In function '__ttc_clocksource_read':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:96:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clocksource, cs)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:163:29: note: in expansion of macro 'to_ttc_timer_clksrc'
     struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'timer')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:96:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clocksource, cs)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:163:29: note: in expansion of macro 'to_ttc_timer_clksrc'
     struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
                                ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_set_next_event':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:185:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:185:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_shutdown':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:199:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:199:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_set_periodic':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:211:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:211:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_resume':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:221:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:221:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_setup_clocksource':
>> drivers/clocksource/cadence_ttc_timer.c:358:19: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
                      ^~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:359:20: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:359:20: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clocksource/cadence_ttc_timer.c:372:8: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
     err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_rate_change_clockevent_cb':
>> drivers/clocksource/cadence_ttc_timer.c:398:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_setup_clockevent':
>> drivers/clocksource/cadence_ttc_timer.c:441:23: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:441:49: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:468:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ttcce->ce,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: At top level:
>> drivers/clocksource/cadence_ttc_timer.c:542:29: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
                                ^~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:480:19: warning: 'ttc_timer_init' defined but not used [-Wunused-function]
    static int __init ttc_timer_init(struct device_node *timer)
                      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers//clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has incomplete type
     struct clocksource clksrc;
                        ^~~~~~
   drivers//clocksource/timer-sun5i.c:60:28: error: field 'clkevt' has incomplete type
     struct clock_event_device clkevt;
                               ^~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers//clocksource/timer-sun5i.c:13:
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_shutdown':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_oneshot':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_periodic':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clkevt_next_event':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_clksrc_read':
>> include/linux/kernel.h:852:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:852:48: note: (near initialization for 'cs')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers//clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clksrc':
   drivers//clocksource/timer-sun5i.c:171:3: error: implicit declaration of function 'clocksource_unregister' [-Werror=implicit-function-declaration]
      clocksource_unregister(&cs->clksrc);
      ^~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:175:3: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
      clocksource_register_hz(&cs->clksrc, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_setup_clocksource':
   drivers//clocksource/timer-sun5i.c:223:20: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     cs->clksrc.mask = CLOCKSOURCE_MASK(32);
                       ^~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:224:21: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:224:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clkevt':
   drivers//clocksource/timer-sun5i.c:251:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ce->clkevt, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: In function 'sun5i_setup_clockevent':
   drivers//clocksource/timer-sun5i.c:291:24: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:291:50: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:305:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ce->clkevt, rate,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c: At top level:
   drivers//clocksource/timer-sun5i.c:361:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun5i_a13, "allwinner,sun5i-a13-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:363:35: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(sun7i_a20, "allwinner,sun7i-a20-hstimer",
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//clocksource/timer-sun5i.c:326:19: warning: 'sun5i_timer_init' defined but not used [-Wunused-function]
    static int __init sun5i_timer_init(struct device_node *node)
                      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..

vim +/clksrc +52 drivers/clocksource/timer-sun5i.c

4a59058f Maxime Ripard   2015-03-31   46  
3071efa4 Maxime Ripard   2015-03-31   47  #define to_sun5i_timer(x) \
3071efa4 Maxime Ripard   2015-03-31   48  	container_of(x, struct sun5i_timer, clk_rate_cb)
3071efa4 Maxime Ripard   2015-03-31   49  
4a59058f Maxime Ripard   2015-03-31   50  struct sun5i_timer_clksrc {
4a59058f Maxime Ripard   2015-03-31   51  	struct sun5i_timer	timer;
4a59058f Maxime Ripard   2015-03-31  @52  	struct clocksource	clksrc;
4a59058f Maxime Ripard   2015-03-31   53  };
4a59058f Maxime Ripard   2015-03-31   54  
4a59058f Maxime Ripard   2015-03-31   55  #define to_sun5i_timer_clksrc(x) \
4a59058f Maxime Ripard   2015-03-31  @56  	container_of(x, struct sun5i_timer_clksrc, clksrc)
4a59058f Maxime Ripard   2015-03-31   57  
4a59058f Maxime Ripard   2015-03-31   58  struct sun5i_timer_clkevt {
4a59058f Maxime Ripard   2015-03-31   59  	struct sun5i_timer		timer;
4a59058f Maxime Ripard   2015-03-31  @60  	struct clock_event_device	clkevt;
4a59058f Maxime Ripard   2015-03-31   61  };
4a59058f Maxime Ripard   2015-03-31   62  
4a59058f Maxime Ripard   2015-03-31   63  #define to_sun5i_timer_clkevt(x) \
4a59058f Maxime Ripard   2015-03-31   64  	container_of(x, struct sun5i_timer_clkevt, clkevt)
67905540 Maxime Ripard   2013-11-07   65  
67905540 Maxime Ripard   2013-11-07   66  /*
67905540 Maxime Ripard   2013-11-07   67   * When we disable a timer, we need to wait at least for 2 cycles of
67905540 Maxime Ripard   2013-11-07   68   * the timer source clock. We will use for that the clocksource timer
67905540 Maxime Ripard   2013-11-07   69   * that is already setup and runs at the same frequency than the other
67905540 Maxime Ripard   2013-11-07   70   * timers, and we never will be disabled.
67905540 Maxime Ripard   2013-11-07   71   */
4a59058f Maxime Ripard   2015-03-31   72  static void sun5i_clkevt_sync(struct sun5i_timer_clkevt *ce)
67905540 Maxime Ripard   2013-11-07   73  {
4a59058f Maxime Ripard   2015-03-31   74  	u32 old = readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
67905540 Maxime Ripard   2013-11-07   75  
4a59058f Maxime Ripard   2015-03-31   76  	while ((old - readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
67905540 Maxime Ripard   2013-11-07   77  		cpu_relax();
67905540 Maxime Ripard   2013-11-07   78  }
67905540 Maxime Ripard   2013-11-07   79  
4a59058f Maxime Ripard   2015-03-31   80  static void sun5i_clkevt_time_stop(struct sun5i_timer_clkevt *ce, u8 timer)
67905540 Maxime Ripard   2013-11-07   81  {
4a59058f Maxime Ripard   2015-03-31   82  	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
4a59058f Maxime Ripard   2015-03-31   83  	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07   84  
4a59058f Maxime Ripard   2015-03-31   85  	sun5i_clkevt_sync(ce);
67905540 Maxime Ripard   2013-11-07   86  }
67905540 Maxime Ripard   2013-11-07   87  
4a59058f Maxime Ripard   2015-03-31   88  static void sun5i_clkevt_time_setup(struct sun5i_timer_clkevt *ce, u8 timer, u32 delay)
67905540 Maxime Ripard   2013-11-07   89  {
4a59058f Maxime Ripard   2015-03-31   90  	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
67905540 Maxime Ripard   2013-11-07   91  }
67905540 Maxime Ripard   2013-11-07   92  
4a59058f Maxime Ripard   2015-03-31   93  static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer, bool periodic)
67905540 Maxime Ripard   2013-11-07   94  {
4a59058f Maxime Ripard   2015-03-31   95  	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07   96  
67905540 Maxime Ripard   2013-11-07   97  	if (periodic)
67905540 Maxime Ripard   2013-11-07   98  		val &= ~TIMER_CTL_ONESHOT;
67905540 Maxime Ripard   2013-11-07   99  	else
67905540 Maxime Ripard   2013-11-07  100  		val |= TIMER_CTL_ONESHOT;
67905540 Maxime Ripard   2013-11-07  101  
67905540 Maxime Ripard   2013-11-07  102  	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
4a59058f Maxime Ripard   2015-03-31  103  	       ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07  104  }
67905540 Maxime Ripard   2013-11-07  105  
7486f5ad Viresh Kumar    2015-06-18  106  static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
67905540 Maxime Ripard   2013-11-07  107  {
4a59058f Maxime Ripard   2015-03-31  108  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
4a59058f Maxime Ripard   2015-03-31  109  
4a59058f Maxime Ripard   2015-03-31  110  	sun5i_clkevt_time_stop(ce, 0);
7486f5ad Viresh Kumar    2015-06-18  111  	return 0;
7486f5ad Viresh Kumar    2015-06-18  112  }
7486f5ad Viresh Kumar    2015-06-18  113  
7486f5ad Viresh Kumar    2015-06-18  114  static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
7486f5ad Viresh Kumar    2015-06-18  115  {
7486f5ad Viresh Kumar    2015-06-18  116  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
7486f5ad Viresh Kumar    2015-06-18  117  
4a59058f Maxime Ripard   2015-03-31  118  	sun5i_clkevt_time_stop(ce, 0);
4a59058f Maxime Ripard   2015-03-31  119  	sun5i_clkevt_time_start(ce, 0, false);
7486f5ad Viresh Kumar    2015-06-18  120  	return 0;
67905540 Maxime Ripard   2013-11-07  121  }
7486f5ad Viresh Kumar    2015-06-18  122  
7486f5ad Viresh Kumar    2015-06-18  123  static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
7486f5ad Viresh Kumar    2015-06-18  124  {
7486f5ad Viresh Kumar    2015-06-18  125  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
7486f5ad Viresh Kumar    2015-06-18  126  
7486f5ad Viresh Kumar    2015-06-18  127  	sun5i_clkevt_time_stop(ce, 0);
7486f5ad Viresh Kumar    2015-06-18  128  	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
7486f5ad Viresh Kumar    2015-06-18  129  	sun5i_clkevt_time_start(ce, 0, true);
7486f5ad Viresh Kumar    2015-06-18  130  	return 0;
67905540 Maxime Ripard   2013-11-07  131  }
67905540 Maxime Ripard   2013-11-07  132  
67905540 Maxime Ripard   2013-11-07  133  static int sun5i_clkevt_next_event(unsigned long evt,
4a59058f Maxime Ripard   2015-03-31  134  				   struct clock_event_device *clkevt)
67905540 Maxime Ripard   2013-11-07  135  {
4a59058f Maxime Ripard   2015-03-31  136  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
4a59058f Maxime Ripard   2015-03-31  137  
4a59058f Maxime Ripard   2015-03-31  138  	sun5i_clkevt_time_stop(ce, 0);
4a59058f Maxime Ripard   2015-03-31  139  	sun5i_clkevt_time_setup(ce, 0, evt - TIMER_SYNC_TICKS);
4a59058f Maxime Ripard   2015-03-31  140  	sun5i_clkevt_time_start(ce, 0, false);
67905540 Maxime Ripard   2013-11-07  141  
67905540 Maxime Ripard   2013-11-07  142  	return 0;
67905540 Maxime Ripard   2013-11-07  143  }
67905540 Maxime Ripard   2013-11-07  144  
67905540 Maxime Ripard   2013-11-07  145  static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
67905540 Maxime Ripard   2013-11-07  146  {
4a59058f Maxime Ripard   2015-03-31  147  	struct sun5i_timer_clkevt *ce = (struct sun5i_timer_clkevt *)dev_id;
67905540 Maxime Ripard   2013-11-07  148  
4a59058f Maxime Ripard   2015-03-31  149  	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
4a59058f Maxime Ripard   2015-03-31  150  	ce->clkevt.event_handler(&ce->clkevt);
67905540 Maxime Ripard   2013-11-07  151  
67905540 Maxime Ripard   2013-11-07  152  	return IRQ_HANDLED;
67905540 Maxime Ripard   2013-11-07  153  }
67905540 Maxime Ripard   2013-11-07  154  
a5a1d1c2 Thomas Gleixner 2016-12-21  155  static u64 sun5i_clksrc_read(struct clocksource *clksrc)
59387683 Chen-Yu Tsai    2016-10-18  156  {
59387683 Chen-Yu Tsai    2016-10-18 @157  	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
59387683 Chen-Yu Tsai    2016-10-18  158  
59387683 Chen-Yu Tsai    2016-10-18  159  	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
59387683 Chen-Yu Tsai    2016-10-18  160  }
59387683 Chen-Yu Tsai    2016-10-18  161  
3071efa4 Maxime Ripard   2015-03-31  162  static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
3071efa4 Maxime Ripard   2015-03-31  163  				unsigned long event, void *data)
3071efa4 Maxime Ripard   2015-03-31  164  {
3071efa4 Maxime Ripard   2015-03-31  165  	struct clk_notifier_data *ndata = data;
3071efa4 Maxime Ripard   2015-03-31  166  	struct sun5i_timer *timer = to_sun5i_timer(nb);
3071efa4 Maxime Ripard   2015-03-31  167  	struct sun5i_timer_clksrc *cs = container_of(timer, struct sun5i_timer_clksrc, timer);
3071efa4 Maxime Ripard   2015-03-31  168  
3071efa4 Maxime Ripard   2015-03-31  169  	switch (event) {
3071efa4 Maxime Ripard   2015-03-31  170  	case PRE_RATE_CHANGE:
3071efa4 Maxime Ripard   2015-03-31 @171  		clocksource_unregister(&cs->clksrc);
3071efa4 Maxime Ripard   2015-03-31  172  		break;
3071efa4 Maxime Ripard   2015-03-31  173  
3071efa4 Maxime Ripard   2015-03-31  174  	case POST_RATE_CHANGE:
3071efa4 Maxime Ripard   2015-03-31 @175  		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
3071efa4 Maxime Ripard   2015-03-31  176  		break;
3071efa4 Maxime Ripard   2015-03-31  177  
3071efa4 Maxime Ripard   2015-03-31  178  	default:
3071efa4 Maxime Ripard   2015-03-31  179  		break;
3071efa4 Maxime Ripard   2015-03-31  180  	}
3071efa4 Maxime Ripard   2015-03-31  181  
3071efa4 Maxime Ripard   2015-03-31  182  	return NOTIFY_DONE;
3071efa4 Maxime Ripard   2015-03-31  183  }
3071efa4 Maxime Ripard   2015-03-31  184  
4a59058f Maxime Ripard   2015-03-31  185  static int __init sun5i_setup_clocksource(struct device_node *node,
4a59058f Maxime Ripard   2015-03-31  186  					  void __iomem *base,
4a59058f Maxime Ripard   2015-03-31  187  					  struct clk *clk, int irq)
4a59058f Maxime Ripard   2015-03-31  188  {
4a59058f Maxime Ripard   2015-03-31  189  	struct sun5i_timer_clksrc *cs;
4a59058f Maxime Ripard   2015-03-31  190  	unsigned long rate;
4a59058f Maxime Ripard   2015-03-31  191  	int ret;
4a59058f Maxime Ripard   2015-03-31  192  
4a59058f Maxime Ripard   2015-03-31  193  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
4a59058f Maxime Ripard   2015-03-31  194  	if (!cs)
4a59058f Maxime Ripard   2015-03-31  195  		return -ENOMEM;
4a59058f Maxime Ripard   2015-03-31  196  
4a59058f Maxime Ripard   2015-03-31  197  	ret = clk_prepare_enable(clk);
4a59058f Maxime Ripard   2015-03-31  198  	if (ret) {
4a59058f Maxime Ripard   2015-03-31  199  		pr_err("Couldn't enable parent clock\n");
4a59058f Maxime Ripard   2015-03-31  200  		goto err_free;
4a59058f Maxime Ripard   2015-03-31  201  	}
4a59058f Maxime Ripard   2015-03-31  202  
4a59058f Maxime Ripard   2015-03-31  203  	rate = clk_get_rate(clk);
4a59058f Maxime Ripard   2015-03-31  204  
4a59058f Maxime Ripard   2015-03-31  205  	cs->timer.base = base;
4a59058f Maxime Ripard   2015-03-31  206  	cs->timer.clk = clk;
3071efa4 Maxime Ripard   2015-03-31  207  	cs->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clksrc;
3071efa4 Maxime Ripard   2015-03-31  208  	cs->timer.clk_rate_cb.next = NULL;
3071efa4 Maxime Ripard   2015-03-31  209  
3071efa4 Maxime Ripard   2015-03-31  210  	ret = clk_notifier_register(clk, &cs->timer.clk_rate_cb);
3071efa4 Maxime Ripard   2015-03-31  211  	if (ret) {
3071efa4 Maxime Ripard   2015-03-31  212  		pr_err("Unable to register clock notifier.\n");
3071efa4 Maxime Ripard   2015-03-31  213  		goto err_disable_clk;
3071efa4 Maxime Ripard   2015-03-31  214  	}
4a59058f Maxime Ripard   2015-03-31  215  
4a59058f Maxime Ripard   2015-03-31  216  	writel(~0, base + TIMER_INTVAL_LO_REG(1));
4a59058f Maxime Ripard   2015-03-31  217  	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
4a59058f Maxime Ripard   2015-03-31  218  	       base + TIMER_CTL_REG(1));
4a59058f Maxime Ripard   2015-03-31  219  
59387683 Chen-Yu Tsai    2016-10-18  220  	cs->clksrc.name = node->name;
59387683 Chen-Yu Tsai    2016-10-18  221  	cs->clksrc.rating = 340;
59387683 Chen-Yu Tsai    2016-10-18  222  	cs->clksrc.read = sun5i_clksrc_read;
59387683 Chen-Yu Tsai    2016-10-18 @223  	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
59387683 Chen-Yu Tsai    2016-10-18 @224  	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
59387683 Chen-Yu Tsai    2016-10-18  225  
59387683 Chen-Yu Tsai    2016-10-18  226  	ret = clocksource_register_hz(&cs->clksrc, rate);
4a59058f Maxime Ripard   2015-03-31  227  	if (ret) {
4a59058f Maxime Ripard   2015-03-31  228  		pr_err("Couldn't register clock source.\n");
3071efa4 Maxime Ripard   2015-03-31  229  		goto err_remove_notifier;
4a59058f Maxime Ripard   2015-03-31  230  	}
4a59058f Maxime Ripard   2015-03-31  231  
4a59058f Maxime Ripard   2015-03-31  232  	return 0;
4a59058f Maxime Ripard   2015-03-31  233  
3071efa4 Maxime Ripard   2015-03-31  234  err_remove_notifier:
3071efa4 Maxime Ripard   2015-03-31  235  	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
4a59058f Maxime Ripard   2015-03-31  236  err_disable_clk:
4a59058f Maxime Ripard   2015-03-31  237  	clk_disable_unprepare(clk);
4a59058f Maxime Ripard   2015-03-31  238  err_free:
4a59058f Maxime Ripard   2015-03-31  239  	kfree(cs);
4a59058f Maxime Ripard   2015-03-31  240  	return ret;
4a59058f Maxime Ripard   2015-03-31  241  }
4a59058f Maxime Ripard   2015-03-31  242  
3071efa4 Maxime Ripard   2015-03-31  243  static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
3071efa4 Maxime Ripard   2015-03-31  244  				unsigned long event, void *data)
3071efa4 Maxime Ripard   2015-03-31  245  {
3071efa4 Maxime Ripard   2015-03-31  246  	struct clk_notifier_data *ndata = data;
3071efa4 Maxime Ripard   2015-03-31  247  	struct sun5i_timer *timer = to_sun5i_timer(nb);
3071efa4 Maxime Ripard   2015-03-31  248  	struct sun5i_timer_clkevt *ce = container_of(timer, struct sun5i_timer_clkevt, timer);
3071efa4 Maxime Ripard   2015-03-31  249  
3071efa4 Maxime Ripard   2015-03-31  250  	if (event == POST_RATE_CHANGE) {
3071efa4 Maxime Ripard   2015-03-31 @251  		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
3071efa4 Maxime Ripard   2015-03-31  252  		ce->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
3071efa4 Maxime Ripard   2015-03-31  253  	}
3071efa4 Maxime Ripard   2015-03-31  254  

:::::: The code at line 52 was first introduced by commit
:::::: 4a59058f0b09682200c04b1db236b4a3b92128d7 clocksource/drivers/sun5i: Refactor the current code

:::::: TO: Maxime Ripard <maxime.ripard@free-electrons.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--k1lZvvs/B4yU6o8G
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICFJp4FgAAy5jb25maWcAlDzbktu2ku/5CpWzD0nVJvGMnUlSW/MAgqCEI5KgAVBzeWHJ
Y9mZyszIR5KT4/367QZ4AUCQ8r7YYnejATT6DnK+/+77Bfly2j9vT48P26enr4tPu5fdYXva
fVh8fHza/c8iFYtS6AVLuf4ZiPPHly//+eVxe/V28fbni4ufX/90eHizWO8OL7unBd2/fHz8
9AWGP+5fvvv+OyrKjC+baqlJkrMmZxuWq+s3HTxlWfsr50pfv/rl6fH9L8/7D1+edsdf/qsu
ScEayXJGFPvl5wfD+1U3Fv5TWtZUC6muv3ZQLt81N0KuAQLTf79Yms08LY6705fPw4J4yXXD
yk1DJM5dcH395rLnLIVSwL+oeM6uXzkzGkijGay1nzEXlOQbJhUXpUMMWyN1rpuVUBr3cf3q
h5f9y+7HnkDdkGrgou7Uhld0BMD/qc4HeCUUv22KdzWrWRw6GmL3U7BCyLuGaE3oakBmK1Km
ucOqViznyfBMajj44XFFNgykRlcWgXORPA/I49Dmhmh3agvUkrHutOD0Fscv749fj6fd83Ba
S1Yyyak53JwtCb0bmLi4SoqExVFqJW7GmIqVKS+N1sSH0RWvfOVKRUF4OaYuFPfZDMSgC0m9
dPaN0qOgN2slaklZkxJNxhw1B+3ftKJsRJ52UqJV/YveHv9anB6fd4vty4fF8bQ9HRfbh4f9
l5fT48unQXSa03UDAxpCqahLDbsFNsDDojdc6gDdlETzDVs8Hhcv+xMaTscrUSmKmDLQJqB3
lCLENJs3A1ITtVaaaOWDQCo5uQsYGcRtBMaFvwMjCEnrhRqrC2pUA7iBBTw07LZi0mGrPAqz
yPEgWDfIHgy/EKWPyUgpan199XYMBB0l2fXFVbge+EEo89ms9UoygtLj4vq1iykFTfBofPoO
Cj9K5p6kh7xnUrgHGKeCrcVOueZ52iS8vHS8EV/bH9fPIcScu+sNkUMG9sYzfX3xmwvHOQty
6+J7nwv7L/W6USRjIY8+WhjXU4PXN7FE0RVLrRk5rm4pRV05mlaRJWuM3jA5QMEX0mXwGDjk
AQZxAidMHXXP1+1MA8zYeBRjn5sbyTVLyHi1dieORyZcNlEMzVSTgLu+4al2/CiYcJzcQiue
qhFQpgUZATNQ1HtXTi18VS+Zzp2YACepmGvQqAQ4UYsZcUjZhlNPX1sE0KO1R/SwJUiqLMLN
86dK0HWP8lwpyIOuKwGqBWmEgkzBsT4MyqoCg3S2UWvVlG42AQHYfYa9SQ+AW3afS6a9Z6uk
pNYiUApw63CYKasko0S7pxZims2lc9ToM31FBNGadEY6PMwzKYCPjTBOXiLTZnnvBjUAJAC4
9CD5vaseALi9D/AieH4bmx0zJhC8TY1+/vS/QypFG1FBgOP3rMmEhEAs4b+ClIGSBGQKfkRU
JUx4wAuXsAqRumdriWzwhcwy58sSXCHkJNLx7J62hRGjgHyOowo4TMEwCoxPo4zHHmMMjKsY
wW0ChyHfzWbXQKPuigiksaN7SQ3wRIm81gxFCsYVjQI9cQKJtdGpiYhvvbIjHtfsWJ7BAbsm
ZdhltbuvDJZy64yphCcNOASSZ47mGgm4AKgYSu0C4IgiYl2Bv3YUgDvqSdINV6wbE1izSdJd
9hXlzbuay7VDCLwTIiV3Tx5ALE2ZN/Li9dsuNWnroWp3+Lg/PG9fHnYL9vfuBbI0AvkaxTxt
dzgOOcumsDvtYpWruHmdjFwewtoQZRTNTU/Q6ohuElMF9YeucpLEbAc4+WQiTkYSEx+wUGsk
BCFRBMvB8F4RqTnx9V2zwrjlBooknnFwatxdLYSOjOc2q+v0k90yGuiWsHRsyEBMOtCDh8Gm
CnDkZ+iu3iZQaxirR4dMMVV1xkimo8PizCbJjXMxWd5KCMduupReFVXDUywhTdYXlASmKMVE
NICbBNjWumj2UG9CJAtpbBoJuRHEwgiRWR7N1wEEsoCGVDxaoRiCsuA2KaNFdUtXXvEA3tnM
B6LQDOvwiN4YJpEqI1hHrA4BoQVUhUjt0lTFKKqSY6IirXOm0KaNY0KnFoxmtyjeTvD9LoaD
WxG1ivpLrgi4PoWSiuJtPt6wDJbE0YizTEUJh7k2BSSWRnpRQkODoU+AfwR7kCXLG3lz+/8i
7noQ04Ngx6hYHBTrW+ZwyK28Q3LbcqFi89P77XH3YfGX9YKfD/uPj09eXYpE7ZzuYfTTGHxr
2xOFiiExWYM2GVbKUAtdbi7Fm+ZtdGMuzdvmt+lj62wYTYaKFZNw0BOOkpeZmx6BtDAKut7C
REpVYAx7HahwqNO4OIpFkesvWlRdRsF2RI/s9wHotlEVV892OFTGLdmE5Ds6vhxNrTDm4/RR
jBezHbhakYtgoQ7q8jJ+dAHVr1ffQPXm92/h9evF5ey2jau4fnX8c3vxKsB2Ke9onx2iS7/D
qXv87X2sKvfrXEz8FVUc/Ny72mtHdiVBopZRoNfbG+oHzZZQn0ZKi3tRhqUvgsGPCq39sG2K
3yIFIMNEwEuUEXeT6BGgUe/GsOJdOCHW1pkK9g+BXFQm2TB+p9oeTo/Yd17or593Tm5lkhJt
1DndYInhBl7IMsqBYhLR0BqqEzKNZ0yJ22k0p2oaSdJsBluJGyhDGJ2mkFxR7k4OpURkS0Jl
0Z0WfEmiCE0kjyEKQqNglQoVQ2B7MOVqDa6RuQ4AEp7bRtVJZAgUMTA5GMPvVzGONYyEyo3F
2OZpERuC4DCLXka3ByFTxiWo6qiurAmEjxiCZdEJsLd/9XsM45jPSIig8sU7rE9GMMyeTMVj
m+hioR7+3OElilthcGGbEaUQbku7haaQFeHMToOvxdDs3QCEh7bX1KIHTt2Fh8+/g3bkr172
+8+Dz3w3s4CK+M0cosoLTwNKIypV8dLEOtc/Dp0s6xoO+4fd8bg/LE7gGkzL/ONue/pycN0E
J1dOE8MUDMMjusHG65lBkUjX5tpqUOjC6daaVMbk12kqGx0yLBluGtBtIqhZgFNLg85ZuXSb
feqGC68XZ5JIU3OAelaVkH4K1GYtKJ4EUt91JLbIGwUlGmb3sFSI0UsBoWDllHdt/882U7EH
02zAOLEpOi5xoMbmiYTt2P5+kIMrprEjyaRN9mFBjqoU3LMcZ4tGQ0QB+Xsm8U7QtPTc8IJn
B0pAie23TRRJUByAf1r2hA7aXEUhUcCz3ZYrUgNP+TJeKrTIZqPTaYJV1dzfXpzDd2c9TYcO
TJWX8wT1JnLmXJOS14WXh9A1mBS7m+Y2nP/b9cyqBrLf17FeQkB0cbV21Hl1f33562sn975v
Ll6/jlWW9w0QepXcffPGJw24xHFWu1YSr8qmVpvIvGGudRtoftEYRWpvKq48JL2jub2jGRwq
FJBOGLdpOt6IoHcRMgWNHm5MVOG40dIYjLp++/qPfpaV0FVeL/07IqPn9sKiu/Ft6c7RSPi1
YaHRqcLxWWC3aIOJqpqQ2u6FVgxTUsgblu4lAOS1rKj06M6qg29EDjU/kXHVa6mi7Uk73rQM
nJWznGGJarcG6bVfY2Y50YADwZc1iZU3kFPAL82XA5XXITO57TdzcGQEEzfYlW7sYPd80eOb
/nIFhxJ2rvsJN/BP0d9Ihd0RVgRVggduZ3ZntSEK1kpkGhneCpBjLtbmIn5JnAhhJIn1rmEf
q4erHFSm0mYJVocD/gm6ay/TsQDbx6RBghSBQf4qw6bi6k5NBN4ElMUtT8G0TCi/vuggphml
BbZ8vNgOW9Q887rAa+Wcb5frmCOC5NYswDNZmjNiY4+bqoCm+HeP1LubgyQgyFt7kFs2IBAD
qrruXci9z/a+EsLJk++TOh2yrfs3Gb5iMDyb7oSgTj7WvsQDu6u8uq8jNWmM4++w0WncPGYn
a2+IDeMb0zUM9DFuvaHG9vYZmoKh6Ew8ihzMKYr2uLdH6mhL7Z6NMdTunvq1qz/gF8ZWvhLY
ogTFuA8c4dAXZETmd02VlaiAJU9jga8nxulNZ53dalYqv4hR3RWQWbO1fu6kPJ1zACnn2HYI
nI6ZwFzrrrER32iYIwh/BSXg7CnEAXnnqAmTmfe2RBvuc9MVew44NExKkMi/sHPX42xaE3Bg
igcQyJJIkTdldtPl+apcpLu/Hx/ctB6ZcUHfDOzN9YJjOJIoOPbaxFvDJns8PP+zPewW6eHx
b6+IgkIPAmPFUTJaUDCn5zEK6/XuPaEenXFZmIrVuvCgRqSpWzMV3D2oFFvweMkzMDMgSkqs
xFdYBOGFJzLKwBDbdwzMTgC2+IH957R7OT6+f9oNO+N4//Rx+7D7caG+fP68P5yGTSIjSPCd
+TpIU9lL9ClE7wLBiHzTQkIMF9iSxOwfLEy60kM8JZXCTpil8XHmnbvnwWIQhn2oiuhV22wa
NaL17tNhu/jYbfmDOcxhm9imLTTeFjjLzDP/2snoPupGvzW8XVgxXKHbj7K8FJW88tZpjVXU
sfSlHVSAw3EqbJjQ1cVq/8/usHjevmw/7Z53LydTvBLQs8X+Mza73D6XE4uqUbMDIF37K0Sl
gDPv5qViAmruZfF9p4vL1w5DUVXeBN4FEzz3PXNjDI68bt61ZjLcmYxc7Xh8I5yjQhkE7goS
gZVuRW4sMaU+fXcdaec2VbdyqmaX0oho6cZ6D2wujx3jRxyjfVT2EUmttSgDYEZCSOplXwaE
7juTDKSlVIBq37cTYExB+yBAc+/1Th8ZrIBXUIP7oHiVgRi9gnKA5AF9GyCHGx2zjRrcA2ik
Ss9cRlnGJs2oK8jqoinlcBDhtijH++vwKNHZgPqMzhI7AP7i23UWTK9EiEOzRNtZQbJsHLko
87uA49iIQKD4Dotky6C7bNcFv422dO91LrLD7t9fdi8PXxfHh217ZTaL7NxGqyiO5+pUZyk2
+NavbPwXs1x0+IJjj/Qzuh7c+UIcO/XqTpQW7U4R/12T+SFoZ+Y1rW8fIsqUwXri/ZfoCMDB
NJvRazDzo0yFXGseqwA98foiilJ0gnECgYvvpTCB77Y8gXb3N0HSb+Z6eMt48TFUuDaIHj3F
s4LRHuMW1lSQiUOcDjK3zrcZjW21P/ly7ELa4gew5P9eVLSgnPzoBDi3943GPoorxgOM3q2C
AIMe3qvnOr+GI5DAJyeus0AAOHdJRzSjzNXAlReIW8goHA/wLu4NHY8ON28vPhnGsW8iHpQx
1lLBvVZFIA7IBYLNQ0Xvb9K+IBGtuBFbmOzdXU33xnx7iPG1RKQGjthWm20HC6/+AwXQdeId
SeO9fI4ALjY+oJKBalVE8eC1sOCeydGguFr5GUqIaXhSOC8zOVg6yVGtKhofA1VOZ0jp7vj4
6eUGU17ALOgefgw5vk0qAf7n/nhaPOxfTof90xOkmCPLrij2hVxBojmGzyZbbyh3OxEwzNpa
O9lPD9vDh8X7w+OHT25ldgdpn8PPPDbCeRHVQiABFKsQqHkIgVSx0bXbcG0pBdTniVO0V+nV
b5d/OJXo75ev/7h092X6YSV+XwQe01H8knkXOBrMf+nf9SOQdTCz+3J3+md/+At95zhhh0qN
ud7DPEPxRJwX7fGq038KCG4z6ZgiPkGenPkvhhgo3uz4w4Is1oBUnYBDybn7kY1B2DYbC6BG
Rkp799sGwSvs1Q3MUTRrdjcCjPmqwlFyeAj2y71j4JXtm1KifGhf7EioW7y7ogqK8aTRErxY
8F1KxwybsCYL9XGGU0tB3Eu5HrdhMhGKRTA0J8rzKICpyip8btIVHQOxch5DJZFVoI8VDyTO
IYvGsryob0MEWgu+fjWmj7FIJCjUSMiF2VwENCvHiheqaDYXMaBj/uoOe8BizZkKt7nR3F9k
ncb3k4l6BBj27i4LkWTlq1nDVDWG9OblY0KFN0BjCuHCDCYKtIaGrTotSalMXTpJMc8gYSwc
O7ajRtMqBkZxRsCS3MTACAIdU1oKx2kga/i5jLx106MS7ph6D6V1HH4DU9wItzLrUSv4FQOr
CfhdkpMIfMOWREXg5SYCxDTTdLnGqDw26YaVIgK+Y67a9WCe57wUPLaalMZ3RdNlBJokjovv
6heJaxndXHRjrl8ddi/7Vy6rIv3Ve98PbPDKUQN4ah0t3splPl3rAv3XIg3Cft2B4aNJSepb
49XIHK/G9ng1bZBXY4vEKQtehQvnri7YoZN2ezUBPWu5V2dM92rWdl2skWb7XYy99/K34zlH
A1FcjyHNlffJEEJLvPwwNwH6rmIBcrRoBHrRwkA8j9tB4oNnYgQusU7wy8kQPA45PfAMw3GE
sfOw5VWT37QrjODsi0YxzKogfnoYlAgAwY/RgZgWRK79KFbpqs0KsrvxkGp1Z5qukKEU/nUb
UGQ891KaHhTWSwNi7IQTydMlc9h1bSgsGCBt/fj4dIK6YOKT/oFzLAluUSgRXq69COyj7Pe/
M3j7ofsMQS4cp1fiJ0llaS4cPaj5/tR2uUIwMMIORZRHExybixofqovFKz41gcP2azaFNJ8B
TSG7Nvw01ujLBN5oZ8Ba26ssiCm0imP8hNBBKKonhkD6kHPvjTZ3GQQ7VWRC4JmuJjCrN5dv
JlBc0gnMkLbG8XD4CRfmq884gSqLqQVV1eRaFSnZFIpPDdKjveuIBbngXh8m0CuWV26BN7ae
ZV5DbeIrVEl8hiW+tsKY97FbC57QnQEV04QBO9IgREXUA8GhcBAWnjvCQvkibCRZBEqWcsni
3gdKD1jh7Z03qA0qY5AtSSPwsWvReFe/SqUPK5gmPkRq/7msC/weyoPRgEZhhm5i5hhuPlgY
QROu8S7a59p+LO8BAyer27+Z4m+CqHfBJlDCwT5IMEok/8J80YOFPt+AxEhEzO+9DrDReej2
m0gfNpZJxpMRYHy4aV1FT3YKnt2kY3ivare9Wpnoe3vavn/aHRcP++f3jy+7D4v2z+HEIu+t
tvEpytU4lhm0Mrvy5jxtD592p6mp7Ft97d+DifNsScxn96ouzlB1uc881fwuHKouHs8Tnll6
qmg1T7HKz+DPLwJvZM2HzvNkuXs/GSXwrDJCMLMU3xAjY0sW+IYYTXZ2CWU2mcE5RCLM2CJE
2CRk6syq55z6QKXZmQXp0PvHaKR3Hxcj+SaVhOq6UOosDRR8+O1lFRrt8/b08OeMf9D4p5rS
VJqKLj6JJcK/fTCHb/+uySxJXis9qdYtDWThkOGeoSnL5E6zKakMVLbgOksVRKs41cxRDURz
itpSVfUs3mRLswRsc17UM47KEjBazuPV/HiMjuflNp1hDiTz5xO5JxiTSFIu57UXivJ5bckv
9fws7Zc2syRn5YENgXn8GR2zLQyvexShKrOpurknEWrenMVNeebg2lugWZLVnZrMazqatT7r
e8L0bkwx7/1bGkbyqaSjo6DnfI+pSWYJhH9rFyMxL2SdozB9zzNUEls/cySz0aMlgVRjlqB+
41x/8qpNDb1n/Ezl+vLXqwBqC4iGVyP6HuNZhI8MmqRVX6nEGLZw34B83Bw/xE1zRWwZ2XU/
6XgPBjWJAGazPOcQc7jpLQKSZ15G0mLNX2wJj9R1lubRNvS/+rCgm2iBUK/gASr86232g1Nw
vYvTYftyxHcM8K89nPYP+6fF0377YfF++7R9ecDr72P4nrFlZzsBOrj17BF1OoEgNoRFcZMI
sorD20bEsJ1j9wVtuFwpQ8HdjEE5HRGNQd7b8AYiNtn/UXZtvXHjyPqvNObhYBbYbPribtsH
yIOakloc62ZRffG8CD5JZ2KM4wSxs5v8+2WRlFRFljxzBsgk/VXxIl6LxWJVkNM2TAhYUGSc
+YgKEXygsFA52F+Zz1bZ9JerbOz6K5Tm/uvXx4f3Rj08+3R+/BqmJNoXV24q2qArEqe8cXn/
79/QQqdwd9VERil/QU7pYtQO+iS7god4r83xcDjQghtPd4sVUHulQ0AAhUCIGp3CRNFwo++r
GgJeUFr7jIAFjBMVs6qziY/kaAYE9c4+AZNcJi0Q2ZbRpzE+O9CrghsUGWrweLWzofgaVwCp
XlgPJY3L2lfWWdwdhzIeJyIzJjT1cEXCUNs29wk8+3BGpYorQgw1j5ZMzuskxdgxEwz+Sd6r
jH9g7j+t3OVTObpznpzKlGnI/iAbtlUTHX1In5v3xh2Jh+tRz/drNNVDmjB+iltX/r35/64s
GzLoyMpCSePKQvFxZdm8YybdsLJs/PnTT2CP4NYFD3UrCy2aY53KuF9GKOiWBLbmHI1ZLry0
/XIRfK5bLsgF/WZqQm+mZjQiJHu5uZigQe9OkEDZMkHK8gkC1Ns+DJpgKKYqyQ1eTG4DAqOL
dJSJnCaXHkzl1p4NvxhsmJm7mZq6G2YBw+XyKxjmKOtBWR0n4un88jdmsGYsjQJSbyXRdp8b
hxDMpLT34HQkurvx8F7GEcK7B+u12Muqv2JPu2Trj19H0wS4pNy3YTIgtUGHEiJpVES5mi+7
FUuJigqfKDEFixQIl1PwhsU9HQmi0KMbIgQaAkRTLV/8Icfvp+hnNEmd37HEeKrBoG4dTwp3
SFy9qQyJYhzhnspc71JUH2gN6sRolmcHvQZmQsj4eWq0u4w6YFoyB7eBuJqAp9K0aSM64jWM
UPpUYzWd69Ps/v2f5IlSnyw0UTG4dd5PDq++JsYgHh9AXbzdwUWiIF4gDMEZtlkzUmOvA5Zs
+CnCJB84pZtwGDKRAvxbcC4QgD+swRTVOcPD48GWSAwvm1iRH9ajN0GIkSAAXsu3Er8mgF96
wdOldLizEUyO4lGLNG36h5YJ8ULRI+AXU4qCJuxyYh4BSFFXEUW2zXJzdcFhemz4BlBUuQu/
wqeYBsWBCQwg/XQJ1gGT1WdHVsgiXC6DCS93+pCjwCMWdZRnqbCEueU99IhqpoWKvHmiqJIU
AL2NQY6iCFgNhcvDEJJJipZtZe6Zlw3EW4FSmS/Qe80CXfyPWLc7YAN1RCgIwW7UYw5u4/bt
9nOsCdE/iM7yRH4Yh4YNdWWX3+ASDl1U13lCYVnHce397JJS4Of6p+Ua1SKq8UujrCLfscmr
Y413KQeEvjt6QpmJkFuDxriap4AQS+/TMDWrap5AhWxMKaqtzIkAh6nQKUQljYn7mCltpwnJ
ScuqccNXZ/daSlg7uJriXPnGwRxU0uc4PAlMJkkCQ3V9wWFdmbt/GBfxEtofO71GnP5lASIF
w0Mv/n6ZdvG3rsrMDnv7/fz9rLfVt87FH9lhHXcntrdBFl3WbhkwVSJEydregyZCSYCa6yqm
tMazXTCgSpkqqJRJ3ia3OYNu0xDcsUXFKrhpM7j+O2E+Lm4a5ttu+W8WWXWThPAt9yHC+K8J
4PR2msL0UsZ8dy2ZOvS2uCE3eADrDXwf75+fHz46nS0dPiL33tpoIFDTObgVsoyTU0gwk+ki
xNNjiJG7JweYN6roPaFDQxNqU5g61EwVNLphaqDnXIgylg32uz2LiCEL7+LU4OasDu+OCSUp
aMyrEbOOG1HYMUQS/sM5hxujCJZCmhHh3gl2JBh/PhxBRKWMWYqslXfvaT48Et6ryAjsgOHu
2Ksq4LsIH6R2kTUZ3oYZFLIJJjbgKirqnMnY+l3xQN/IyVYt8Q3YbMbSb3SD3mx5duHbtxmU
nkp7NBhHJgPO4qQvs6iYT5cp89322UL4slIzm4yCEhwhXNocYXJWa5h2k1muJH7TEwvUk3Gp
IOpOBcHxkGSsN5fIeGLmsP6f6HU2JmKf/giPsZMKhJeChQv6jBFn5AtmPm2kVHVSHtRRwuz+
zID0/gITDicySEiapEywh4aDFR/Qem5d/f41IXzs4Ay+6SlSzyVvvQek26mK8oRyn0H1pPPe
9WTK30jNlxEXEADnK9D62RcriHTbtCg9/OpU4U2FUmBPYA2O9tWkJv4cfoJzwnQXJApyMeOf
IwQPdc1ZBKKWqbuOhq/Z3tK3PmZvcAow+vx79nJ+fglktfqmpUbd1tLP03BkUdFE8ejfub5/
/+f5Zdbcf3j4Mly2Yx9l5IgCv/QEKSKITHAgTobbpkJLWAPvlp2EEJ3+tVzPnlzdPxiXaqGD
gOJGYlFjUxPLuG19m4CLIDzN7/So7CCGVhqfWDxj8DpCedxFqMoCzyNwh0YU0gBsBWXvdsdB
Cop6Z3GhmzfgPAS5qzyAiO0TACLKBVyRw+M8fKYHWp6QQGywrrTXC69+TVDGb1H5uz4HReXK
q86+vJAUOkEgnRPJobZbulfLCci4awHvICxNeKUJcXk5ZyCIl8LBfObSeH4r05jCRVhF9VsE
TnxZMCyzJ/ClJoUKHFqMuPehdRLdsNyOwLNL4mRQ4zeHCMZ4yJ+fQlBVKV1wEaiFDzyKFYSl
6f35eaO4EPVyvThh9r3aTrLD52u61yYqBnDpjVSG031hgJsWCdArUMMEqA32YAMGksC+5k2Q
vcL9FkfcyicbsrPKhlpSNbAn4t9xZHz9R4PlD+QbeOkwfNbPs94a9NalsD7IUFPAm8ZDiWpc
Pn38dv/t/OGNsZEKllTrvlI2k4ut3t7bOy2kDs804y9PfzyeQ6uquDJ3dUNVEiV7bNwURCvV
nQrwNrlpoiKEK1mslvoE5hPgaZeVKjxCEW301PPRnWy2Mg+Z9RhdLEP2CuKQJvkNRNANP2A5
n4dZgZdZCNIQ4CqOfv89TxjC9fp6RK37z1e6QQ/Xfig6RMmdPh5pETzFb50OuW52ghRCUWCL
L47gEjCJccAUPaBSOmAHqGtJpBadtkxqmpkGwLuqryfvSdbEhqGKoqU5ZTL2AEUS4KGmfwZK
LcMS0zQqyVMaRBuBXSLijKcQl+hwmzeI69aD2OP388uXLy+fJnsPri3LFsur0CDCa+OW0kHj
TRpAyG1Lli0Emtx+coQGR6jsCSrGpzCL7qOm5bAuu/AzMPBWqJolRG22umEpeVAVA6+OsklY
im01vvTgew1O7glwpXab04mlFM0hbCFRLOerU9DUtd7bQzRleiVu80XYUysRYPk+of6uhs5j
+uOQ4f166yrvA13QvbZLMHKU9H2vGXBVQU49UaoPIA2+rOsRz2p3hI1fui6viNvQnuodZZvT
DYlFmHY3eEqotkmioo/oNMBgbNTQgGUwfHLiCqBHOuI9+piY54l4rBmIhpI2kKrvAiaJDowi
3YHOHHWx1c0vjMdgcJcR8oJwkeQVRCGB6K+wZTBMImnaIVxlV5V7jqlJ9I8kz/d5pA8vkjzc
J0wQj/BkLkMbtkL2Mrnmkoee3nuKveWKcigh3nLfAGJI4N92IB9JrxAYbjZIolxuvYbuEV3K
Xa0HMt6CPJogCk2P2N5IjugNUnc5gsrvEeM4FjtnHAiNADf8MH7z16ld1v4Fw2GKY3D6/2pB
vZPHXz4/PD2/fDs/dp9efgkYi0RlTHq6fw5wMC5wPqr3u09OoTSt5iv3DLGsfI8nA8n5N5vq
nK7Ii2miaoNIBmMftpMkCFc/RZNbFZg1DMR6mlTU+Ss08Ck+Sc2ORWDDQnoQzOiCNZZyCDXd
Eobhlaq3cT5NtP0axhAmfeBerpxM+J0x/uRRwhufz+SnyzCHBfPd1bBhpDcSX3TY3944daAs
a+yvxKG72tc+X9f+7z6smQ9TQxcH+hEyIolU7vCL44DEngZHg/REmtSZsX4KEPBzpeVwP9ue
CvEXiAZ8VLylxOQd3BvuZIsdaQNYYgHDARDrLASpfAJo5qdVWZyLUSV5/22WPpwfIQ7158/f
n/rHG79q1n842fnZqgvGLKycwlg3AbFt0svry3nklSoLCsCOssAKHABTfL5wQCeXXhvV5fri
goFYztWKgWi/jnCQQSFFU5kowTzMpCDCX4+EBVo06C4Ds5mGHa7a5UL/7be0Q8NcVBuOJItN
8TKD7FQzw9GCTC6r9NiUaxbkyrxe49vtmrvfIxdfoaeuHjH3bOP1k/4cL9TOrqmMtOZdeegl
gMrgRXRn5+9AcI51PW2xDXd8fjp/e3jv4Fnlq4/2Nq67eyj9k4VNGIt3vwwSgS64LWq8t/dI
V3ixrlpwlkMDjemFyeQ9hBzZ7mWOBPz0GITYGFhlOUZldjQtDTbRwIFqOeRj3MgGX8iScYSS
fqOJTPSHAw590R9FcrhQ4WlTqNEe6jMCrsqgU2wS5aNGs2ATBFHNDC2y+7nl6O9mRmPQO9Vl
d/rLDlLRCOhBDEbwt+70mlwUxmRH4sLY33TGOExhv9IDhkM3OLAo8CVXn2ODogRAiEmV6X6N
9ShJU9JompQmpUicp4tey/L9Ge0RjheOrF2yldh7q4SJDFE8iN91/Vdpwz6N062NyQ/T7IpC
uoLgBNcERp0gWSttE1HMxDF7s5jMoNuXLkYk9mkVssFyT8M8AA8O0urVpUo5NGouOXgris3q
dBpIpnn3z3oRKazPn1n09GHWwsPaR7tD5/c/6Q0c5JLf6EHlZ21aIIS6BslTaUt2Lf9X1xyR
QpvSmzSmyZVKY+K1mZJN21S1V0sTnowgQ9xbCIdn7of7YddExdumKt6mj/fPn2bvPz18ZS4k
oXNSSbP8LYkT4V2pAq5nZcfAOr257gf/mhUOLdATy8pFVRsDZzrKVq+0d21iPosPMu4Y8wlG
j22XVEXSNt7ogym8jcobLZHF+pyyeJW6fJV68Sr16vVyN6+SV8uw5eSCwTi+CwbzakP8YQ9M
oKUkdk1DjxZaHIhDXG+fUYiaMBh0jcHXzgaoPCDaKmuFa0Zrcf/1KwqXMfv45Zsds/fvIRCx
N2QrWClPfWA9b8yBi40imCcW7N2acQng27SkOf9xNTf/cSx5Ur5jCdCTpiPfLTlylfLV0cvf
AWJQ6PZL+Eppjl0Cgb8pWYn1ci5i7yu1cGYI3u6g1uu5h5HrUwvQ29oR66KyKu+0GOW1MxxJ
bcRGksiMqe7Q6HnvUeBiORgX+eBvqR8K6vz48Q3EWbg37tw007RBBeRaiPV64ZVksA7UPTjM
OyL5+gBNgcCAaU5c3BG4OzbSeqwn/mcpTzDNiuW6vvIaX+njx9qbMCoPmqbOAkj/8TG4f2wr
fRy22gkcPdNRkyZSNnTwu8XyCmdntrilFSesxP7w/Oeb6umNgKk3ZexhvrgSO/xezjp70sJf
8W5xEaItCmIK41TL4F0ihDd6HWriGfz0KQzvVmQTOWyxCalp3iIw8BoSxIkWbuQkIZwrmBi3
0zQlGudEZ2dH+PxHmi7mV/PFVZDEKXjI1mcIlVlewN0YHEomdj/DKWPF1MVGAwlxfQ7C0S3G
ukt1U5Uik/7aQolWFGC8JL/GGxtb6/lfs2Zyl72e5XbbmvnIcemxecFUXkRpwsDwP6J5GSih
JczYK6cy4lr7kG4Wc6qxGmgK4qwKX8ozpEwquZ5zlS5aTyzVol44HRzoFqeOaZmeo4/PziYP
Vq+esDxBx+xg7XHiZV7r3pz9j/17CaGnZp/Pn798+8mv0oaNFnproiAzEqWCqHj+5lG0V4sf
P0LcMRv1w4XxMa1PNCQWtBZmVJ2Y0NxY4IaAWvqwDce1230UEyUOEFOV8wToq06lXl6g3tF/
+8L0fhsC3THv2kxPhQwCCHsLtmHYJltnFbmc+zQwnSHn3p4Anom50rwg1XGLFlccH1JLGvtS
ttTOQIP64KcTbRUBIWCwcZyLQRuLlyXFd2VUSEEzdusBg9EYURonZ/DKKKLJ74JcHMOp0svA
BLHyMnGqZoJBcN48wnEKvUCZtYBDF73r64HPHtDhK+geU3r+YeX1yOsZhyOCCVUmedoguY3B
whxxpwQXJcxRo9PV1eX1JqyIFhIuwpLKynzOiONYPCYQj7siM1dpYzCr0OpMM9NIX/pETq2a
HdCVez32tvjFoa6NjAfDo/r+2/3j4/lxprHZp4c/Pr15PP9b/wxDc5lkXR37OUEk4RBLQ6gN
oR1bjcGbV+CH2KWLWmzC7MBtLYKv7Kg1kwP1uawJwFS2Sw5cBWBCvDojUFyRPrcwCV/mcm3w
87UBrI8BeEOC0vRgi4NtOLAq8ZllBLHDBDckwExUKdgPZL1ank543P+u9ycubLBOKupbiLmm
OmyJZgAlFERQxdE7+rLiSFxv5mEd9oV5EjeU2+OiOjopc6IWwJRX+E0nRuFK3F5FjjeHQ9Zw
81/xaeNmi8Yw/OrsFbs1aiFxVIeZhZP0oLphwEpxnKerECQnEwS6b1psOFpwaMHEOEKnNxE3
YNx+04r4gG2fMex0smpsQEo+ehccEAseVnz6iN09DSELz4iZERO2aBaHWMO1cqNO+LHQoUis
aU/ACCQe9apgoDTaNlIoL2fv7tcwCg+wLmNY0ButmMLk7CgTBWjc5WY1Pg/P70O9uEpKpeU3
8MG4yg/zJTbqitfL9amL66plQar5xwQiwsX7orgzosC44GRR2WL9lNVhFFIfAfBqpXYQCFMg
Mb2VaeH1noEuTyekktDdcr1aqos5wqK20EUo/JpYy6J5pfZNAiKCteYmRZ9QT2R1J3Mk8Zj7
BFHJEq7rUCl1rK6v5ssox96ZVL68ns9XPoLX4L4fWk1ZrxnCNluQxww9bkq8xraGWSE2qzXa
nmK12FwtcYvBSnu5XpCYkuArF4clBZNQ9+orVdH1BVaqgMSp20sf/euVixKNamZPLcPmQp5f
mZ+D/Db34KZKQTG3prDIwLlyL+l4WZvQgwNtvPsTSychmsGfJDrvIrRFt7geHEs0yEZwHYB5
souwy2EHF9Fpc3UZsl+vxGnDoKfTRQjLuO2urrM6Uag3xfZSH3DpkLeYb9gxgvoApvbFcD9g
WqA9/7h/nkkw7vr++fz08jx7/gTm/sgv6uPD03n2QS8TD1/hn2MrtaCHDocerBluEbCPssDZ
1f0srXfR7OPDt8//gQivH77858n4WbXiGXoFBqbdESiB67zPQT69aKlOn1vMJZ5VhA1vD4RM
GfhQ1Qw6ZpRBFNkpooCwr0wxk/xftLQJ+vEv32bq5f7lPCvun+7/OEODzn4VlSr+4d++Q/2G
7Pq9LavgOQZ5PbNLyuNt4v8eVCJd0jQV3P8K2D7vxpmTiIzoscQph+fwE1HCNTFK9/1dcVVz
97zm1CWxXSo+ATye75/Pmv08i7+8NyPJ3Py9ffhwhj//evnxYi4TwNHq24enj19mX56MnG7O
CPi9iBY5T1p26KgNLMD2bZqioBYdmDOMISlNo8w77EfW/O4YnlfyxBv7IPeZpx4hDuyM3GHg
wSDR9J9iyzLCMJecntpMy0TqBrZEbKpvzkZNpU+zw2SH9obbHN2r/Zr39v++//Hx4YffA4F6
apD7A10cqhicRTncXNan6XAWFRJX5Tlcf3GegumJKk23VdQwot5kxeFedLNcTNaPLSdKxGaJ
xcSBkMvF+rRiCEV8ecGlEEW8uWDwtpFpnnAJ1JpcIWF8xeBZ3a42zEntN2MAxoxPJRbLOZNR
LSVTHdleLS6XLL5cMA1hcCafUl1dXizWTLGxWM51Y8PzqVeoZXJkPuVwvGFmppbWqJw4EKQs
oh0zu1QurucJ14xtU2jZLMQPMrpaihPX5fosvxHz+eSY6+cDnCL6u7VgKphzMXGr0EQSlqi2
wXIpHETIr84WgBH3lN5Di9vBypsSvMXD1NJVb/by8+t59qsWCv785+zl/uv5nzMRv9HCyj/C
OYzPrSJrLNaGWKUwOqRuOAxC0sYVfpHQZ7xjCsPXU+bLBgnfw4UJnU4eQxg8r3Y7Yo9uUGVe
QoORFWmithecnr1ONCrwsNv0eYyFpfk/R1GRmsRzuVURn8AfDoAaiYM8T7OkpmZLyKujNake
dxmrtyGeIA1k5G91p1I/D3HabVeWiaFcsJRteVpOEk66BSs8l5Olx9oPnNWx0xP1ZGaQl1FW
43fYBtLc12Re92jYwBF9gWWxSDDlRFJckkwdAPsDeJJvnKUd8q/TczSJMkafeXTXFerdGtlG
9CxWzE9KE935J08ttKzwLkgJd6PWMBweKpX+WgBs1361r/+y2td/Xe3rV6t9/Uq1r/9Wta8v
vGoD4B+S7BD4L2PXsuU2jmR/JZczizotknpQi15QJCXByVcSlMTMDY/LldPl037UsV3T5b8f
BEBSEYFg1iycFu8FARDPABCIUK5TsBorrwuYGIljQB4rcp6b8nopvVG6gQ2TmrcSOM41nYfD
bVriAdENZibBEJ/GmaWonSLMTAlWOn56BN7NvoOJKg51LzB8bTsTQrkYGUREQygVe3XjRLQf
8Ftv8aEwqJVJ2zVPvEAvR31Oea9zINUgmIghu6VmAJNJ+5Yn8nqvyiHOsNSmV8Twnpx9xAMX
fXIfWWFZdobGPnHkE1VW9lGwD/jnHy8dbGdltankinGq8SaeSpHrKxOYkCsQTkRo+KCpSl4K
6kU1Q940WPHuTmhQlE67lk9AXc4HXv1cbqI0Np03XGRAkB+PLsHchF1CBkthJ9/xiVlS3jfF
WShokzbEdr0Ugugqj2XKO6lBZm1kjlNFcAs/GYnD1LLpCLzEn4qEbOx2aQlYSOYUBIqDFETC
psinPKNPR7x74Cb/5iidY7qGl0b7zV98uIIi2u/WDL5lu2DPa9dlk7WuUppBmzImMrWTA460
WCzI72E5IeOcF1rVUmebpJvpKPe+ozgq4J2TYBOinI/4kXesEXe16MGu6Wy8zoStB4zA0GYJ
/yqDnk2/uflwXgphk+LC+2itM9fJqWX5mbsUvMwBzewEa3f5eKeyNG1nSUfMIidgY9rd+cCr
diDITgil6EYHbOcML02dZQxrytkHUvr1y49vXz99At3V/3z88btprF9+0cfjw5f3Pz7+7+vd
fgySzW1K5OrZDAkju4VV2TMkza8Jg3rYi2DYU02ObW1CpirSYIvblUsfZEopY1oVeFvaQvfN
FfjYD7wUPvz5/cfXzw9meJRKwKytzaiJj5FsOk+aNg+bUM9SPpR4IWsQOQM2GNrkhVoj2ww2
djOd+og1p0IXsxPDx7YJv0oE6LKBejBLobwyoOIAbMIrnTO0TROvcLD29YhojlxvDLkUvIKv
ilfFVXVmSrvvtv5/y7mxDakgJ/2AlBlH2kSDvaujh3dYgnFYZ2rOB5t4u+sZyje9HMg2tmYw
EsEtB58bairWomYybxnEN8Rm0MsmgH1YSWgkgrQ9WoLvg91Bnpq3IWdRI81eyZmhRau8SwVU
Ve+SKOQo31mzqOk9tKc51IimpMdb1G2yecUD4wPZlLMo2PYjSxSHZilD+DbjCJ45kpvvb291
+8ijNN1qG3sRKB6sq/VZHfgnedurjdfDLHJT1aGuZgXsRtW/fP3y6SfvZaxr2fa9oksHV5tC
mbv64R9SNx1/md8BcKA3E7nXj0tM+zIanSO3Pf/n/adPv77/8O+Hfzx8ev3X+w+CnmgzT71k
pPd21m04b3Eo7Mnj0aY060lV5bizlpndkFl5SOAjfqD1Zksw54c2wXok5aiIQ7Lp+3w+OKUU
9swnmREdNxC9TYD5UKi0iuKdEpR+MlRVJpy0AWtgFrGN8IjF2SnMeEOuTKrklLcDPJDNShbO
mm/2TWxA/Ar0gJXGY5OBm7w1va2Dm7kZEesMZ/WhCKKrpNHnmoLdWdlLa1dlRO+KHHBCJLTc
J8Ss8J8ENC3yhHgAzuzVClqkygqTGAI3R3CfVzfE16hh6BrDAC95S4tZaFMYHbDNd0LojlUX
qLRixN2mJrVwLBJiFNlAoE7eSdBwxLYaofSZYd/xw60iOhowJ3d4VGPGrBoVu4AJGOhe4HYH
WENXjwBB4aIpCXSMDralMbUmGyX2DTpq/tFQGHUbw0gkOjRe+ONFEwU790xVjkYMJz4Fw7tL
IybsRo0MuTswYsSA44TNxwbu9DXP84cg2q8f/uv48dvrzfz7b/+856ja3Joz+8yRoSZrgRk2
xREKMLEheUdrTQ1uewYrS6VIAGbwCmZJ2oFBkev+mD9djMD5wi3NH1E7VdydQpdjlcUJsds3
4GMsyazh64UAbX2psrY+KG6Q+B7CLDvrxQTApuQ1h6bKTenfw4A9gENSwBUbNIckKTWbDkBH
HVbSAOaZ8MyiNreifcImDU3kOqfODMwvXTObEyPmK/pbH8wFs/sMCJx6da35QWy9dAfPyEx3
QXkl32GY4WqbSltrTUwrXiWNTtI0q4Lb+x6uLVqH6Et1yku4iInkkZZ63nHPgxE0Ax9cbXyQ
GFwesRR/0oTV5X71119LOB4Wp5iVGUWl8EYIxqseRlAZkpNY7QT8STlFHWwiD0DaEQEi53Kj
A6tEUSivfMDfzXGwqWiwytHiqykTZ+Gh64dge3uDjd8i12+R4SLZvplo+1ai7VuJtn6iMJA6
w4K00F48v2Ivtk78cqxUCjecaeARtNenTINX4iuWVVm325k2TUNYNMTanRiVsjFzbQrqLMUC
K2coKQ+J1klWs8+441KS57pVL7ivI1DMIvOspjzjY7ZGzPRkegnzyzah9gO84zgSooNjRDBX
cD8EILxLc0UyzVI75wsFZcbiGtm8VkekV+ktvKwVrw4LehYBvQFnA1/AnytirNvAZyyYWWTe
B5/uFv/49vHXP3+8/vag//Pxx4ffH5JvH37/+OP1w48/vwm3uycvauU1jvPtCt/EmKiDken0
EWsHbSLyYDM7WrchOFwYkwm4bysRuk0OHkHzSA5DPGo4FbWZzEM6FUKQpzSJkfBr3QCQG270
epudqqwiyhCZodo7L4jSDT78uKPxHk2JdUvOurrn5lx7E6JLJcmSpsMS/whYkwlHIjTit8yq
ENvV7oIo6OWQRZLCSgHf2taFSmvumWkO3+VY6DYrK3Je6Z6HulRmAFcn08tx93CKvp1eyHWZ
vOC4CYWPEMosDoKA3hxpYPokG2Su7KsyJRKXeXkwa4vcR0aXMPMJ2IxbNdg8lU7CIIts03+G
hmsof6YRl6tOJfKHYuug5gEcGqVs1TbBqNlCoNYs4+jlcRwvNOyaiA8FmTqKgD7l9BFXcbHQ
lC5mAY6+yj0P1SGOV2wAGa//ol6WpGiBAE9UOkLJuNUB7nsHbG7PPNgbp8mlq3Ve5Njj08hB
ab7F452fEmoSK6lVPXYuQNq+be8Rfx7Ot5LcAwP9JRqhWXW2qsa3ME+keu0jZCbhmKCG8Ky7
vKR3Yk0a7MlLEDDiEomWOFQYDp3w+iz6PEtMuyf5RnGkyVVdUJ11Z7OEy1uQc8ilT4xfF/DD
qZeJFhOFerooMnhPCIkY59GdE2MVQ3dw3GHPJzM2BCchaCQEXUsYLW6E22NqgcC5nlBi7hN/
itIp+hA6Rqe9Gc3wXdSs4s7SxmiynC4nzWoAXOfet5/yMFjh054RMFNrcRef3EufyeNQ3lA/
GyGiVuGwiqjl3zHTqwYzx6hTQm9ZZvm6R+ch4x7/EK/RCJSV+2CFerGJdBNu/UP+3rrhkAuG
atVmRYgPGU2LpPsGE8I+EUWYlxc4s7h3sTyk44595mMJjuDFjv33KrfPQ9XocZsYPH8O+VJN
532CFXJC3G+uPdabhqfJHiGot9CVBIry2Oa5NiMDasxg2eFYkn0zgzRPTMoC0A4lDD+ppCKH
fji1yzvVaWQjetLUKK/vgliesUD9D2QdVKJn1W/OWTjQgczqCR5zhjWrNZVBzpVmOTYIpY3M
eaTIYpWcUW2em4DPoWMo5u4gJ+Fy6oTIPmLXsacDeeDNy0B40FE9CU+lKOVEJRYBkqswRGJd
kyytV/wFg+DwxzJYPcpFEYcb7LDhXSnLmdO56136uG7XYN2QVGZ5pVVZwnYXNtN1bfAmbNMn
wTZmLrkfcceBJ09/ATAQMeBwE6HPWOHNPPH38NeYT0mqGhvbKnrTMPEupQNouVqQCpYW4va5
in7jB3PQQHRNEeqlpG9+HCPG2wxiQGYtsbdix1GrUBYiF5Ad5M5F8PyIcSzFjXhjZMEWe8qk
uPRNYB2uTAq5lamU2Nh/1HG8RqnCM96mdM8m4gJjL+alflEWtmoFbNyv0jB+h1fsE+KOhLgR
NcP24drQ8vBSPrfY/p15Cla4UR/zpKjk0bVKzEKvxJflR+AeWMdRHMoJW59/VV1iN4BHYn7b
s6SO3o6j/cqbCpKeDbUh84g2hmvSpSG5uhr5ES1xjOid5hnp8yh0/ahwHs4DGTDNWzWTlcEr
IfiwrU7EpcHZLIxNJd/DPudgbPjIjz/GZEcdxPn1pyKJyPbIU0HXLe6ZLwlGlLT6EWM99qk4
0YG2NyMATQG7xzUPQ4H3YgDgiedZTt9oif4NIIqaYgCIis64TC5JYW263IOnyY5Mjs4u8NL6
pc1h8wKJfHEQ7fFWOzx3de0BQ4Mlvgm0u+rdTWni1Gpi4yDcU9RqxLXjzYo71cbBdr+Q3wpu
CaA55Uznpja5yksHUOe5J7BdreX+CbsNOO/jsxRUJyWc6KC8WLFgqdvoPH8SK9EIawlqdjrd
h6sokOMg06nSe6J6q3Swl79K10XSHosE755Rg2Ng7r7LCDuUaQYX9iqKsiY9B/SvloEnAWif
FU3HYTQ5nNdSp94Yp8t0H5iCQeNMo1Kqxm/e2wcBsd8zYc7m1rmuH6X74DbUemHA1p2djdBn
dSWI8FQicpi/bZHdAAdNzqda03cc5ekiOVg1T/EKr90cXDSpEfo9uMypposFmUFBB/qbaQ7X
dQpWDTwYa3RNUIm3I0fwUvXKL46F6d2ExrNA0zyXOZY23DkpWtiDO2B8tlepixhxl58vHV5X
u2cxKA6mhrQxYk9CPC56fsTHN694pjQPQ3tWeKN0htiqGHBwepUSBRgU8U29kC169zzcNqSZ
z2hk0bmpj/jhokcz7KJ9BBRKVX44P1RSPcs5Yk4q7p8xbi/wHgxw2Mi77/q5qhvQwLzvPJge
0xd0tXrHaMs6ZvjCR5YfSQeBR36z5RFLXKY3EGP+dZK14MwCDfp3bChAW8datmAuLPSBLkrd
cZC7SkhBOGJS1tGaj19A8PYI1R0S4vnboqZ2yksvo8uJjDx1/0MoKKw258mNO50UFGKR9hQs
Uaf2iIWC4zYnQ9nRQ3N+JhuC+gYqFHPpF0ZC6lp1ApVBRzhzUEo9mMdFU89wDkJVMcYDDIZ2
8SrqKWYK11415WC8E8AhfT5Vpmg93IrG7NOmUwAaOlVpkrF8ZaY+vIBZY1Ye61gAtzsKHlWf
s+9XaVPwfDq7Vf0teaY4+FbNu2AVBCkj+o4C464EA2HCGk49h+3a0sdqZ8jXg2HZReHK7psm
LI4nP+Ao+FIQBAGGdHmwwlcE4KTPVJxKWUGN9xoo6JyBDyfTFMP2RNTRxk81q+P9fkPU18mm
ctPQh+GgoXkw0AxyRvLIKchdywJWNg0LZTU86a6vgWuiAwIAea2j6ddFyJDRmACBrA8XohOg
yafq4pxSztrWhxsS2Bq0JeyNWYZZ9Tb4tZ1GALCM9Mv3j7+9Wofbk8EHmO5eX397/c1a8QGm
ev3xn6/f/v2Q/Pb+jx+v33xNRrAUZk/WR2Wlz5hIky6lyGNyI5IeYE1+SvSFvdp2RRxgW2h3
MKSgEUZ2RPAD0PwjK/opm2CHNdj1S8R+CHZx4rNpllo9AZEZciyRYaJKBeJ8MWWglnkgyoMS
mKzcb7Hu24Trdr9brUQ8FnHTl3cbXmQTsxeZU7ENV0LJVDDUxUIiMGAefLhM9S6OhPCtkbmc
qQq5SPTloO1OibUf8EYQyoFp+HKzxR4/LFyFu3BFMefNm4VrSzMCXHqK5o0Zo8M4jin8mIbB
nkUKeXtJLi1v3zbPfRxGwWrwegSQj0lRKqHAn8xwfbthARyYs679oGaG2gQ9azBQUM259nqH
as5ePrTK2zYZvLDXYiu1q/S8J5eAbmTxPnvbvWFHjBDmrvlSkg0X8xwTp6qgbc89C5AIOqTT
IvjJBAiMSYx6s871FwDMOa4YDlzuWudPZCVvgm4eSQ43j0Kym0eqZuAg68ELLBxWeUGT3z8O
5xuJ1iD80zEqpGm47DjeXTl60R+6tM573/+uZXkaPO8GSs4HLzU5Jd05L8X2fw3yAQ/R9fu9
lPXRy3GeeaSpGGxn3aG3+sah0RkoQ8cit0rRxMvw9LV1XnrVgaeyGVr65vOtxa0kTdpiH2AT
nhPC/JLOsO9XeWJuTSqgLEGTi+1jQTJsnpnL7xEk4/SI+a0JUPDk7G7B35l2swmRBsRNmYki
WHnAoHQLRzwkTnKs556ZirTDeFsDzM/hjLLqsLjcmm5pFW3xdDcCfjx0mClzqkpLrJyCKhKH
3GkERZNut003q55WAE5IUnzCKpfryKkIYXrQ+kABs3jNtQ04WM8Ymui80RDizsg9iHlXsrZt
+GUFrOhvFLAi1yp/8q+i2+g2Hg84Pw8nH6p8qGh87MyyQXsiIKxTAcRvAq4jfjlyht4qk3uI
t0pmDOVlbMT97I3EUibpjWaUDVaw99C2xYDvqdFQJ24TKBSwS03nnoYXbArUpiX1agaIpgpx
BjmKCFw57GCLCJ9iMLLUp8PlKNCs6U3whfShOa5U5RT2b1gCmh1O8sDBdLQSBS5ftdz3mZaH
am4h2ewcATiEUB0eVyeCNQKAQx5BuBQBEHD3u+6w95OJccYS0gtxUzaRT7UAsswU6qCwEwP3
7GX5xvuWQdb77YYA0X4NgF3WfvzPJ3h8+Af8gpAP2euvf/7rX+DtzvN9O0W/lKw/CRjmRrzO
jADroQbNriUJVbJn+1bd2IW5+XMpsC7WxB/gRty4WUEa2RQAGqRZFDezo6C3v9a+43/sHV6a
8JR12K5Qc4R1Gr5J5Z7vfnh/LhBDdSUWwke6wQrGE4YFgRHDnQU0RXLv2d5txgk41N0qPt4G
UE837R1t6RS9F1VXZh5WgQp/4cEwxvuYne4XYF/rpDa1W6c1lQOazdoT+AHzAlF9BgOQ04cR
mA1hOXPj6PMNT1uvLcDNWh6VPEUq03ONWIVP0yaE5nRGUymoZlq7E4y/ZEb9scThprDPAgzX
0qH5CTFN1GKUcwDyLSX0GHydYwTYZ0yonTY8lMVY4DsppMTzTCVkWVwauXEVXOTgbUJ3LNsu
7PGob57XqxVpMwbaeNA24GFi/zUHmV9RhLXwCLNZYjbL74R4F8VljxRX2+0iBsDbMrSQvZER
sjcxu0hmpIyPzEJsl+qxqm8Vp6gu9x1zZ3KfaRW+TfCamXBeJL2Q6hTWH7wR6XziiBQdPhDh
zSkjx3obab5c6cZu+cakAQOw8wAvGwUsjrGXRhtwH+JDxxHSPpQxaBdGiQ8d+ItxnPtxcSgO
Ax4X5OtCICpojACvZweyShbn+SkRb04Zv0TC3RaRwjuyELrv+4uPmEYO21lkdY0rFitumYdh
j6+ntVqQQACkIyogi4tlfF05vVFzRO7ZBadREgZPNzhqrBFxK4IQK3G6Z/6uw0hKAJKthoLq
q9wKqi/rnnnEDqMR20Oqu7eIjFiBxt/x8pxhBTEYml4yep8enoOgvfkIb1GjONMmz6kv5Bix
fIOjNcuneGWiMWtWLR1tuN3/m1MssaLs7WOZ9A9gP+PT6/fvD4dvX9//9uv7L7/5boxuCqx4
KJjXSlwqd5Q1Gsy4aw3O3vVsAuSG961NnuwcjCTNrEjpEzU1MCHsqgCgbgVIsWPLAHKyaZEe
e6MxY4BpsvoZb4InVU/2m6LViqgmHpOWHjtmOsU28+ECqMHC7SYMWSBIj95AnuGB2AgwGcXK
JuYJzKvcS7VImgM7RTPfBeehaGmU5zk0FCOVeieKiDsmj3lxEKmki7ftMcRHTBIrLO7uoUoT
ZP1uLUeRpiGxbEdiJw0NM9lxF2JdcBxhEpMdU4/y83otQbEZbQWOd2EGvN5QOsMXM8zToNYF
5W1b+8mR4fqOgSUJJp2hz+96x/CWSS5kp8ViYND7iL3OWRTa+mRMxzw//M/re3tl/fufv3pe
Hu0LmW0nqp6HDkDXxccvf/718Pv7b785V0TUM0/z/vt3MBX6wfBefO0VVHWSfoov++XD7++/
fHn9dPc3OWYKvWrfGPIL1ocEwzM16jguTFWDfVVbSEWOXQfPdFFILz3mz02ScSLo2q0XWAUc
giHPyUPxqAHwUb//azrPf/2Nl8QY+XaIeEwdnOKRAyGH69UBX0lx4LFV3YsQOLmWQxJ4NnjH
Qiy0h2UqPxempj1C51lxSC64KY6FkHfvsM4gRoeLX2Rp+szBw6PJ5dqLQ6ed9VaMq9oxp+QF
b9o58HxMB6EIbtvtPpTCaq8Uc9h/MSsIKZppVkaV6krV1ujD99dvVsfL6zqs9OjWylwNAjxW
nU/YhuFw0sJ+HTvfYh66zToOeGymJMhgOqNrHXtJ22YGpUOcE9nenCZYgIInbqN7Dmb/kKF9
ZkqVZUVOV0f0PTNqSC+O1GQAeaoogKXBCWfTFDRLDCIy6CEYDnR5LrHX9ZtvU+uTLADUcaoX
6e7N1LFcYT8kpxcup0E78RIAbDi0ijRzRDXLFPylVY1IOL9XmczBcWYnfMtJnRKiTTICrkGh
k5AJN3OreAQy8dZyU1EI5x9TCHDd5qdXgh0gCQ18lIno52cQAT6Txyn/k2CuSJDSfb9uOFQE
tZrdiX62E/Ny83WvmL5K7+1NqFWsE3C6JebEhmtp+zbHrZP5Y9JzHLbrKqpLa3E32DJwnCF4
FA3Rz3WYxneQXX7JIqDCfdU8eBfVDNS2zewuUX35488fi+6gVNVc0KxjH93+xmeKHY9DmZcF
sZTsGDD6Rgy7OVg3ZiGQP5bEgJ1lyqRrVT8yNo8XM3d8ghXXbE38O8viUNamawnJTPjQ6AQr
TzFWp22eG4nvn8EqXL8d5vmfu21Mg7yrn4Wk86sIOscDqOwzV/YZb7vuBSNrMd9zE2JEeVTv
CG02mzheZPYS0z1in8Uz/tQFK6wrgogw2EpEWjR6F+AdlZkqHuVEqH46gW3jyaWXujTZroOt
zMTrQPp+17CknJVxhFVHCBFJhBFid9FGKsoSz1Z3tGkD7A1wJqr81uFBYibqJq9gi0WKbbrU
JhRaXWRHBfftwNCr+G5X35IbtguLKPgNfsYk8lLJ1WcSs2+JEZZYlfn+baZvr6WqK8Ohqy/p
mViknel+oZWCkvmQSxkwM4xpi1KVH1Li+Hnu6Gg+gkczbODBeoKGxDRzIehweM4kGG7Fmv/x
0vVO6ucqaagy2p2czM8LFAiPj01N3FDd2bxIKmpaC6UIYnyB7+miWG35KzHOY53CprgfKUg1
+HKYQ5MGlpUQH2dM6W+IpxYHp88J9vDjQPgQdsee4Jb7ucDp8nDxCu+q+75PvITYPRn3YVPd
SDm4k3SzZZoTQMMQHSBMyJBUiWkQ9xfuRJRJKJYXZzStD9gK9YyfjtgczB1usRo/gYdSZC7K
DL0ltqw9c/YUPkklSqssvyl6XWgmuxLPWPfo7FX2RYLqwHAyxArVM2nWR62qpTyAI86CXBu8
5x1sddftYYk6JNg+wp0DPVz5e28qMw8C83LOq/NFqr/ssJdqIynztJYy3V3Mcu7UJsdeajp6
s8JqyzMBEstFrPcednZkeDgehaK2DFM7sT2gA/14NI64Z6fMnuYpTgZTqoFjN4k6dXjHGhHn
pLqRu3eIezyYB5HxbnuMnBvMTBNK63LNu7UdzpwkiL7sDoJGUgPqndjGNeaTTO9i7Hadkrt4
t3uD27/F0TFK4MkJDuFbI/cGb7wP+qJDiS25ifTQRbuFz76ANYI+Va0cxeESmnVkJJNws6yu
8kGlVRxh0Y4Eeo7TrjwFeAOb8l2nG26E3g+wWAgjv1iIjud2baQQf5PEejmNLNmv8LUjwsF0
hF0JYPKclI0+q6Wc5Xm3kKLpJAVe3fqcN/vjIJNpLJE81XWmFuJWhTItYomkl2ZJnJfqZekj
H7tjGIQL/SsnkwJlFgrVDhHDjTqI8wMsVrdZRQRBvPSyWUlsyG1lQpY6CNYLXF4cYT9JNUsB
mFBGirbst5di6PRCnlWV92qhPMrHXbDQOM1qxghN1cIAkmfdcOw2/WphXCzVqV4YOOzvVp3O
C1Hb3ze1ULUduA2Mok2//MFvjVq3rLPXiRdr+GYWkMFCI7Z3oOqyqbXqFlpsSY5baeMIol28
MF7am2Gu34qDsZ39kuodlvI5H5XLnOreIHMrkSzzroMu0lmZQl0EqzeSb137XQ6QceUdLxNg
0cNM8n8T0akGf2SL9LtEE/vIXlEUb5RDHqpl8uUZLFCpt+LuzGybrjdEOOaBXF9djiPRz2+U
gP2tunBpWu70Ol4an0wV2nlhYaQwdLha9W/MlS7EwgDmyIWu4ciFUb4hbhcw05YD3jDBlFZF
TsRVwunl7q+7IIwWRkS2OUKoS7VemI71pV0vFLmhjkawjpalB93H281SkTZ6u1ntFsaql7zb
huFCO3hh6zci0dSFOrRquB43C9lu63PpxD8c/7glo7CZIYfFMbhk7Ye6IrtEjjSCboBtwmKU
VhNhSImNjJVpTWthc6VjD2VC7oSPm7tRvzKf0pEdvXEXvIz362Bobq2Qa9hN3G33EdjZ6ZSX
yXGsh5flyMsyidd+dk5NmPgYGBHJ8wYvWBHVqaLzdl0Rn5llaOa/m5iJtIXdgjzkFGwOmslm
pD22797tRXDMxXTfh5ZmfQPrjH50z7nTOmZwWgYrL5U2P10K8Em7UOytmcmWy9z2lzCIl0Mk
fROadtrkXnYu7liFN5HU9JFtZOq5vAhcTKz7j/CtfKsy27pL2mcwsyjVmVtLyP0IuG0kc06m
GYQ2nvqHOUnWF5HUIy0sd0lHCX1Sldok4hVOWiYREZQJLKUBAgJsW+jC/DokXtHoOh37sVka
t4lfPO013Jq6PY8btxK93bxN75Zoa5zHtnBS+G2p+NrSQuTzLEJKziHlgSHHFdYpHxE+Y1s8
zKwTZnwvy4UPAg8JORKtPGTNkY2PzHpX5+lkV/2jfoCjSXQ+xjJrrceVsBBwThOaSQD5SV4Y
VLzC6m8ONH+p2XoHN0lLjhxGNFXkWMChZp4TUKKO6aDRE4UQ2EBwIu290KZS6KSREqwL8+FJ
g8/Nx08EoYLGc2FFCLuMtBgmZKj0ZhMLeLEWwLy8BKvHQGCOpVvuOtWT399/e/8BjLl4mrRg
guauY4j1qUeHY12bVLqw1/mxNmI3BUCqBzcfu3YIHg7K+Zi7qyNXqt+bkb3D1s6m26MLoIkN
lrfhZouL3SwxRE/k1mJlR8s6fU6LJMMHfunzC+y1o55X1n3iLmQW9LCiT5y9HeKA/rlKYTbE
+7wTNpywldn6pS6JUgq2GscVDIaTRmdnzg57W1+Ic1OHajIVZ/m1xNYMzPMjAfRJDbrCEh8g
5pPSnkLl4a7bpV+/fXz/ydf8GEs/T9riOSXmMR0Rh1hgQqDJV9OCj4I8s95ySQPD4UDDSySO
UEGPMkc9i+PYiON1RFjr+CKDpw6MV+1wMU1B/3Mtsa1ppqrM3wqS911eZcSgE2L1Ga5PqvZp
4QtzsybulvlWL5TAIS3DONok2Fweifgm43BdKe7lOD1bnJg03bw5q3yhdOFQhxgSpvHqhcIv
VbZAmD7qMdSfsm3Q1dcvv8ALoDAJLdvaw/IUc8b3mQEIjPqjHmEbfEmdMGbsTTqP8xU7RsIs
XiJq4xXjfnhV+hi0xYLsgo2EPg9a6BgOvjf0UOalzkbdiyJwsbxgxCmCRfodHg3RK2bYWi8R
kU+kadU3AhxslYYtRir5cfqNF8nxuMdqrII3smZ4OORtRiytjpTpo9tISG6Uad51yQlqZIn/
Ow4aDUyK/riEAx2SS9bC4i8INuFqxdvXsd/2W789ghF0Mf2y10MiMqNpwEYvvAg6ETZHS21j
DuF3tdYfWUDOM03aFUDAyLYJvRcMdu8DEe8E4MmkaMScmyczrYCHbXVSaV3U/hiozUpM+3ks
Yb8niDZCeGJyeAp+zQ8XuQQctVhyadcWTiWDU6CLdyDntkb6aloz6SJhwz7job1o/LSahmjo
na/p5OnvLik6F7Ip932rmlLBuXNWkIU1oE0CduqZp23E6I7ZUADKGaF1mhVH4jLc0lggc4BW
Rwbdki49Z1ixxCUKK8n6iEInVmd1OHQuwKHEd8hunv/iGYKBARYMZS6yzk6IQMwOIT0m75+r
WotJNWIarJXdCWZd+05wk7httN+icRl0lJTztOSu44w3FpaXJrMEjcUvuNBSJtWwJvsQdxTv
2eq0DcmOSDMZpEO5TG6e00m4OGPx/KrxOuPckMslTW43BBsBmmwvICqpTuk5Bz0SqFuUWMmA
Lj0Nzr4HBpT2vLpb1APYpvQIgooWs0WFKV+HGrPV5Vp3nBRik2O5mo8BZY3+WchrF0UvTbhe
ZtiWP2fJx5r6oobtzLRSPJMRbEKYhYYZro9T+zTpClraZIfLFI3VcTTfje+5uRvXDRbtLGak
eaqnbEBnstpZaP7z04+Pf3x6/cv0BUg8/f3jH2IOzPR1cNuOJsqiyCvsmGOMlOnYTWiTJvvN
Olgi/vIJYvp6AsuiT5sio8Q5L5q8tXat6Ic71UASNilO9UF1PmjygStg3pU6/PkdlcU4gDyY
mA3++9fvPx4+fP3y49vXT59gIPH0u23kKtjg2XQGt5EA9hwss91m62HgoZSVgnMtRkFFVA8s
oslRh0Eapfo1hSp73MPi0kpvNvuNB27J9VeH7bHPBMCu5AKQA5wmiy3SJG2UXHw6tdsW957x
8/uP188Pv5riH8M//NdnUw+ffj68fv719TcwKPyPMdQvZp31wTTm/2Y10vc8N4KZdguDabDu
QMEUuqvfyrNcq1Nl7Q7R8ZKRvnMKHoBcdzJcfiQzooVO4Yo14rzMryyUn0lVnjjQG7nJG13e
vax3MavWx7z0up5ZfGNdVNtN6TRtoW5L7PwCVjPNd9sS0wQXz3yryXI9eE5Swo0mYFul2Be0
jxFL0awYS9P3i5y31rLL2ctWBjmyTqEv1dbIWuGNVY+/x4DR4cjafd7qpPNyMRrgZ1l2qxOG
Fc2eF2ab2g0k20nyv4xM8+X9J+gt/3Dj1PvRoLbYwTJVgyr1hTeBrKhYc2oStoOOwKGg+jk2
V/Wh7o6Xl5ehpqIsfG8CCv1X1gs6VT0zTWs7VDRwoRF2V8dvrH/87uaq8QPRaEA/brw3AA6R
Kiw0uEq+sIScT/SfHjQZsmI9Fow50L2GOw5TioQTXXW6Mm88OyoAlcnoxMlthZphsnz/HSoz
vc873r0ieNEtp5FMClhbggODiFjwtgSVqSzUK/v/6C6McOM+ngjSzT2Hsw2FOzicNRGkRmp4
8lHufMOClw4WU8UzhSf/zxT0d7dsiU/jLsOZH8ARK1XGtpxGnNhKsiDpPrYgm71XDG4B730s
HbgBMQO3+f+oOMrie8f2kAxUlGD4t2gY2sTxOhhabGh4zhBx8jGCXh4BzDzUeZQwv44sYj4H
2EyAn48ns9BlYWs3EjDQrG7MoopF0SmhrUDQIVhhg78WbhXxgWWgRqVRKECDfmJxmvkn5Ik7
zG8ovncni3r51FG69b5Ip0FshKoVyxbMXlrVR456oc5+Mh0U8ZqBVAFphLYM6vJTmxAt1BkN
V4M+FgnPwcxRJQ1LeXOcRY3oXajjEXbvGNP3e4r01skehdgUaTHe2uGwQyfmP+pcC6iX5+qp
bIbT2IrmUbaZrG+44ZYNruYfWVHZ1lzXzSFJnaV19iVFvg17MuaWij6Z2jWLVTAAn+DrKWe8
LWQeyLrPnZ9rhdYgs9ERC3/6+PoFn6dDBLAanD60abS/0Guwdyjz4F0v7hob5uc9jjEhMS4z
8CrwDf3IdhsQVWQKDwGI8UQOxI2D5JyJf71+ef32/sfXb/6CrWtMFr9++LeQQfMxwSaOTaSm
06J0CO67hgZnPtv1ivqZYS+RBg25hYF1Lsb6yPY+7cIaFkIUAuN2qn2iblidMCG8r581tt1j
scm3HUXt/dbVfRPg9fPXbz8fPr//4w+zgoIQvkRl39utJ0den2nOmbzhwDJrOo7ZvUkOdmd8
88VhoF3FQZAOHusqYV/jrdTcNoU35zsNt1vS8KB4w9MBXZv0XlnSo1pcvMLCztEtnc0tqOqG
Id4xpqukQ7zVu55XXV69kEsODjVt7tLgddMImyxL3uUc26RgUY8lMK4nWMNK8ezpVAlhsGfv
cpVhC177eLNhGB+5HVjwgnnpp5EGlv+2Yb7+9cf7L7/5TdO7Fz+iFY/TtX2eSYuGPEd2gyry
UdDW42hnhIcwDnjEpkich1DX047Z33xGq16ghbNGy+4FOZBImRZ6l1QvQ9cVDOar97HRRXts
5H8E4533vU6VmdX0/RCREVbRON56peP0KSV4H/Dv4PcqJnC/X8+jfqr+piT5Rpmr58L0v7NX
oT5iBGxwgxfwD2kzIyIG89AJ4sKb2TBDZoBPJFAb9PKWRlEc8wbUKF3rFqf39dvfd4cybcJI
r+LpPfCx9eYLZKE9EjdsftIekU/dMfjlPx/HDVJPRjIh3cLVWmSoexLHyGQ6XGM/uZSJQ4kp
+1R+IbiVEoFlhDG/+tP7/32lWXWLfOsOnkTicE0Ow2YYMonvJ1AiXiTA7Gx2IB5lSAh8FYO+
ul0gwqU3omCJWHwjGtI2lXO2267kt8hOISUWMhDn+NrHzByeQuo02x5sDskVWwy3EHNUjUAr
CVABgbMgJ4gklac4Az87csyNQ9hddOEkFocpujTcb0I5gjdjBw37rsZe2zE7zs1vcPeMyWnz
jVFMvmDbufmhrjunsH9fvrgkRM5FBI6fimeetkM9U6/gYRN4NAaOElaSpcMhgS0fJHSPuurQ
oy6NB7OYrBMsho0xGtG7i/frTeIzvPFjPF7CgwU89HF9wOfMZ3Bt21JwCgk9pMdSIiPoOeGc
LhMdpiQMTq64oPAEB0EcVjXuNQ8/XvJiOCUXfBo4RQX3X3fkbJwxQramWxI+o3QD7/iEiSze
r4Q3QJjBkvKEU5n8Hk2VnLBuCIo/WG92QkROF7Ieg2zxUR162d798ZknuDusy8PBp0yFroNN
v0DgeRMT4UbIIhA7vFuLiE0sRWWyFK2FmEYJbufXpq1+N8CthZY/GS3ymbbbrKSqbjvTFze0
ra28/ny+lVQnBLzTXbF+poPGzXq3hnY6mO9/gE1WQakYLkJouDYWkX2vO75exGMJL8HwwhKx
WSK2S8R+gYjkNPYhUUyZiW7XBwtEtESslwkxcUNswwVitxTVTioSne62YiG2pv+kZMNzYrq+
EV7I9DYUUjYCpBj/eIGKmGGbOLV5NAuMg08cd0G82hxlIg6PJ4nZRLuN9onpYqCYg2NnhNxL
l3S58Oap2AQxVVydiXAlEmaSS0RYqEQrER2xPYWJOavzNoiEQlaHMsmFdA3eYA8nMw5uzGkH
n6kOe2WY0HfpWsipGTLaIJRqvVBVnpxygbDjmNAQLbGXoupSM1wLLQiIMJCjWoehkF9LLCS+
DrcLiYdbIXFrfULqm0BsV1shEcsEwiBjia0wwgGxF2rDaofvpC80zHYbyWlst1IdWmIjfLol
llOXqsosiyNxRO5ScnV6Dp9XxzA4lOlSYzR9sxeab1FuIwmVRj6DymGlZlDuhO81qFA3RRmL
qcViarGYmtTTilLsBOVeas/lXkzNrIQiobgtsZZ6kiWELDZpvIukfgHEOhSyX3WpW+4r3VHF
6JFPO9PUhVwDsZMqxRBmKSB8PRD7lfCdlU4iaVCyO4t79P0N1WKbw8kwyAKh3GxCI1ULYoUd
08TG44j7LWqspz0HiWJpdBsHGKk7JX242klDJXTZ9VoSV0C838ZCFo1AujZrCKHcL2m2X62E
uIAIJeKl2AYSDjewxYlOnzvp0w0sjS4Gjv4S4VQKzZXtZomkzINdJLTp3IgK65XQZg0RBgvE
9kYcssyplzpd78o3GKmjO+4QScOxTs+brb3jUopjqOWlrmqJSGi2uuu02Ix0WW6lmc0M00EY
Z7EspetgJVWmteUWym/s4p0kkppSjaUGoKqEHGdhXJo/DB6F8jy1E/pVdy5TaYbsyiaQBiaL
C63C4lJXK5u11FYAl3J5Vck23gry5LULQkkmuXbgod7Hb7GRgINMJvaLRLhECN9scaH2HQ69
H+6q+MOf4YtdvOmEcdhR20oQ9g1lmvpZWCA4Jhcpdhwy4T1sjv3zTTXauWWmjfI2xGAWTNCn
jQDoo3vYrVXWgOLQtQobx534ye/jqb6a7pk3w01p4shXCnhMVOsunIoW7aVX4FK7s9f5/35l
3EkuijqFmUw4Dp3eonnyP5J/nECDopr9I9P37Ms8yyvajWoufoU5XQMPzvLrsc2flis4L/+P
sqtrbtxGtn9FT7eS2mwNP0SKetgHiqQkjkmRQ1K07BeVYmsyqmtbU7ZnN3N//UUD/ECjm072
IRnrHAIEgQbQABrde3W5XrsqAm4p+gSDiICJMAG/FFX6hcJ1mYQVhXuDKIaJ2OcBFYLtUuom
rW5uiyKmTFz0hzg62pk80qdXgWdZUKWymqKiyNSVrbEjpbvGnVuHGRibPnMX0PPmRstYJmzO
f57eZunL2/vrj2dpEzOZukmlExJSsialjQYWbS4Pz3nYY0SiCheeo+HqNPH0/Pbj5Y/pcqob
XEw5hYAXjGTIPU2waGqSvBRiHCKTCG0r36i6Lz9OTw/X5+fpksisGxjOxgzvD87SX9BiDFfl
fpqIYbM7wLviNrwr9FgIA9Vb1ahgcaf3h2+P1z8mvfrXxbphruoh+FhWCRhEofd1u000qSS8
CcJ3pwguK3WMTuBxkUs52dAHhriNwwYcJGqIOnWhj3b3bClxn6YVnP1RJqzFctK3OKZZ2lW+
lLEUWbIO8yX3MoGHXjxnmM5kmEvjRmI5yr0pvmVAZeXLENIolWuoNt1F3NXOauc1vh1wRdrv
DlwKMNJw4RSoarh23O2jJVtlymSHJRYO+zGw7cJ/pjrscLjcxETiYHGR/reYPKTJEn60Tqs1
DJfcV4PxFFd6sE5icDmMoMyV1fLmsFqxXQNIDlfBkrlG7e9cM1xn6MVKbhbWC04SxKBZhzUu
c3fFl8vGdcJyAb4XcYIszRdilWPUa+RBY+lQ6ruWldQrA22igkH6gKj7Et+AVPZGRnMruxkM
rqJ8Dm4KTBDuEhBQmv5No+ZZsuAWlhsYxc43pZh9sACUUA2qHkZPPK0/P/iWKSq7Y+gYlbjP
M70heuOkf/5+ejs/jhNGhMPegZOpiBtVG2VR3hvt/EU24gmUDZ6kytfz++X5fP3xPttcxTz1
ckV2OnQ6AhVU19m5R3TNelcUJaNO/1UyeVGemWpxQWTudFI3nzIyq8H5bVHX6SobgqDV15fL
w9usvjxdHq4vs9Xp4X+/P51eztq0rd87gixqHL0eoBUo28hhQS3jYW8LaVcwvJKyRj5zV9qX
rao03pAEcD/9wxz7BzAOkXo/SNbTBppmyIsBYOpaOhRQek3hs8MPsRy2pxGdMSTNIkPtCq1v
9vb9/HD5enmYhfkqHBsFEqG+HtI2kKj68ChlSot4Dq71uJkSHj/OILorD+zTmzyMjlG+m2Bp
ZaBwivIW9tcfLw/vFyGfXbQuuuRYx4b+Cgg1XQFUuYPblOjsUD4unQCts+QQ6bfaRmqbRWYa
Gc/F0vep5OPyVJ7DjGgqayaGjwZOPo3vHcn7EZ01C6qATnNGF+p6XD+9HDCXYMjiRWLIthaQ
biWUlaHuyAEYOKY9mJXTgfgTdIJ8NDgDF0oXabBt6s/FnAOfTwjPOxjEtoFrmXWq+yACDSnV
TVwBQFfBITtpOxzlBQr5DYRpPQyY8tJrcaBnfBaxnulQoSnqVsIjunQJGiwtM4PGR3vNEuvX
MZpGfn9QfkuRZETYlSlAnPkr4KClYoRaKA2eXVHbDagReAg6p3TcQhp0NC3WwaY2bpkpFFvO
DE/i0IaA3gT6jq6E1OLCKFM6X/imHypJ5DjAeg8Zg5rEb+4C0dhazwlXB7nTQkat3qZczc9N
fnl4vZ6fzg/vr91cDfws7QMCMgtteIB2etMcEjAUBYD0L9MOHuycbEu3vlIm7SjwCPGmLd9D
TN8HFNlNdWUybe21hwMGRVbyOkqHkoEho89tZjsLl2nlLHc9U6CQo7BBJ5RMnhaM3ic7Er7t
ISeF7k7DTwakhe8JUvaoni8yZ46zuc09OOEgmB5gQGHBcrlgsIBgsNXOYFTWhgsJSK5v54HZ
h6VLAeWCR3cCRI9WR5/VxmJmJNbpQaz82iJrkPXK+AC4Y9orJ2D1Ht26G5+BXWi5Cf3hU2SQ
HylQOgL9oA1TWB/RuNhzlwHL7MJG1/Y1xlAzRoaqJSNnDPFaxRr2sJjxpxl3gnFstoYkY3PM
Otx5ruexlYfnCs2FuVQCJhjPY6sgrbOla7GvEZTvLGy2jWA8XLCvkgxbQdLSli2EOchhhq8E
MCxAgUwx5S98jqKKBua8YCpZ4M/Zl0nKZ1uX6CQGxUuYpBasIFGFyOSW0+mQ8YnGdaqm4VUc
8SjIDKaCJZ+r0Lx4wQbG4bMztLWRKVdpyI2Jx6n+S9UvjVvv7xObH7HKNggsvjElFUxTS57S
bx2N8HAEwpGGMqYRpkqmUYaqNzJU3dI4NQ8d2zyPuGlEqAie7btsWqoBYc5x+XpU+g8vAVRj
Mjle9qn2RDi21hQ3n34fUqdGzjxqRwye7WELeNj71N2pPZ8fL6fZw/WVibitUkVhDu5Oycap
YlUA0WPTTj0AW8wNeHKdfKIKY+kTniXrmNmz7dJFU0yUfEgZ+spIiD9ighe7poLwH9U0c4xb
7aZWm8YJRCfR3C4oqJ1nQs3dr8BrKIo3P9JmkjBuzeIqQqlWebqDXhfuNnqMR/UE7DHVNwmE
vd2Z2Tb7na5GyYLlSe6I/4yCAyO3kiCu5jHK0I6CzGy1X8NpKYPGsA+1YYg2l0YDE0mgXlMu
GdQyQR1jyhhx8TFFyZTW+fAtznTpnMkvcnDZxA+jVIDsUARS2Dsn/prgMfCtGcZh2YACbvs6
BWEVYWdJNrvW4JJLwO9gnURgKnHMirqGUM/Dpp3s5mSXrorMCVdkjuayqA+zo0caSHWPwWkl
gSM8heFdMqRGeBV5E7jP4p9bPp+62N3xRLi74+IDKVuZkmVyscC4WcUsd8iZNLJqwFOuVjNV
pIUfQlkkO/ybekEUmi6yOFRlwk7GxDONWAeluHidk3+U0nBuB2oNfoK4LIUGSMCZtYtrDMW+
gcm6SsL8HoXXEcXaFFWZ7TekuJt9qHsIEFDTiIeML6gOuoGkrIqN+VvGL/lpYFsK7fQweB0m
JIhgID0UBPmgKMgTQYUYM5iPpKH3tYM+Rrn8SLEs6a54oJrh6BwjRmjTAVIBSPK0aegcBaH1
xplQnbidf384PVNnwvComh2MUd4g+gBjLUwUP/WHNrVyTqpBuYccRMniNK3l6wthmTQLdD1t
yO24SnZfODwCt+EsUaahzRFxE9VIOR0pMUXmNUeAt94yZd/zOQFLkc8slUFEwFUUc+SNyFIP
V64xEGUx5Jg8rNji5dUSLsGxaXa3gcUWvGg9/doMIvR7DgZxZNOUYeToS0vELFyz7TXKZhup
TpDtrkbsluJNuoGzybEfKzp5elhNMmzzwf88i5VGRfEFlJQ3TfnTFP9VQPmT77K9icr4spwo
BRDRBONOVF9zY9msTAjGRr73dUp08ICvv/1OzBKsLIslJds3mwIFktaJPQ7PrlFt4Lms6LWR
hTznaIzoezlHHNJK+VhP2V57H7nmYFbeRgQwtfgeZgfTbrQVI5nxEfeVix3xqQH15jZZkdLX
jiO3rJSd6Mvp6frHrGmlcxUy9ncrhrYSLFmDdLDpsguTzApooODLwc+iwW9j8YT5MpGiTeuU
LlmkwPkWuZiBWPy5nx4vf1zeT09/8dnh3kI3J3RULcp+slRFvig6OGJBfjCz6uDpBMzK5tjk
ProWpKPd8/JT47/4RlgbIK2sA0yBHOB0BaEK9YPJngrRBruWQM703Ct66ijtae7Yt8knmLcJ
ylpwL9znzRGdcPVEdGA/FAwwD1z+m7RpKd6WC0u/vafjDpPPpgzK+obiu6IVI9ER96ielEow
g8dNI3SHPSWKMql0vWZok/USRR/GOFmJ9HQZNe3ccxgmvnXQNZyhcoXeUm3ujg1baqFTcE21
rlL9jGAo3L3QChdMrSTRdpfW4VSttQwGH2pPVIDL4bu7OmG+O9z7PidUUFaLKWuU+I7LPJ9E
tn75eJASoeAyzZflieNxr80PmW3b9ZoyVZM5weHAyIj4t765o/h9bCMHXoBLATyu9vEmaTgG
reXrvFYvqIz+snIip7PPKekoY7LckBPWStq0pclvMJb9ckJD+K8fDeBJ7gR01FUou6vWUcyo
2zFyf6Mzx/v6LuMrPJ6/Xl7Oj7PX0+PlypdGikta1aXWBoBtxQKwWmMsr1PHG33tQX7bOE9n
URL1btCNnMt9VicB7FOOOalFntzpw4s8td/zIPL5we3sdpPJrRfoN1971CeT4X1RhWTOleAx
jlwySykGlBV0iqGTq/39VH72RJIsz/TlG6GqqYRhW/vJXTLEaUSV8+k0qEYT1ZS2DdnKBUyP
zpgWUZMR5Wi9YhNvk0O6z4+bJE936QRp+IBWXH4gAhs3rj2qedyXffr28/fXy+MHHxgdbNLi
QjPx0O3QHg6YR4PguMqEkK9S3SRJY5meJvFkJ6/ptaVr6aF3tSc6ikucl4m5FXtcNcHcGH0F
RAeHOgwXtkvy7WBGU+sZ5ksk5c9xG2iqJ3h/DEmXloNfu7Bt65hWxpgoYfwV3aNFHeNn1QjO
7DZzQ3v/cMrCoTm4K7gEW+YPBvaSZGew3LAvVoFNYczmcS6+0Jixy8Y2Ad3wB/yym2Gf1B76
DkV+AmxblCg4udyS36B9WVmKuLN1RmidpzgeUrehvy8hgAYWink2uNjtbGrJwBCF6+QYRal5
yDDcsmnLdC001FpkdPfhM1FYNnty/iHq0p/PffGKmL4idz2PZertsS32Jpq7TnUMyUINfMov
/iRZuBEcGOpRNOAyjDpD5LBjHYViBIgq3aBGo6mz4qGsyhegmBBJkZVxMAod3HfVvN7v+quC
82NqHg9pzNRK0yuP6zSnlSdwISTpMaqnc4WEH760VGdTXaOa68587i6ERlOuSXubPop19NiU
ZJzsmLYh3yGvtAoBm6pTkqCBOBYZlv/hLHEQ/8Ekr5s/c/HyuAgZw7xO6vpLS21JJbLn8ric
5FrjPKqn+0NOGd4wQ+ENsYxAg24cMp/p9GdmBtL5fE0LcHCEkpmHZUWKjoXzuKFVXYu6XsGo
wBHbNpyA1QBM926AjpOsYdNJ4pjLT5xKR+ICjuMI7ZT95bB1XBK1ouc+08YekkXkq3uqrWmO
DYyPpG0Vyp+oSy7OSWXA9WdW6BEqhF767JwY8NsUOfvTQKnQc0/Lg2AZYNGfm7QQYmNapBOO
Wr4ojU+sW/I8+gQ3a5jVBSzvgMLrO2WWMZxE/8R4k4TeApndKCuOdL6wDnibs8OGJ1UwK4yN
qc1dYBMbvtQk+mzNDPIqMDfz43pVme8WtZ3Kv0ihtmF1w4LG5uxNgpQJuVYPYQNmZ+xf5+FS
X45rFaqvxroXCeVyYflb+vjaD5AFqIKZeMmKUdbU/5q8/g988OdsnXdWArNf6mYmL/RpUenG
rILRq/ggYuvL6/kWXFf/kiZJMrPd5fzXCc13nVZJbO6+daDaE6fWNjAbH4sS7BsG+YZ7+HAL
SRX5+h3uJJH9Adhlndtkdmxa0/wiuhMLurqGguQ41JKp136g8bKDi1wjzH2zCB18bPUQLdAb
03AnRBLV0Ijrq5MRnRjkpQWP0gC05cnp5eHy9HR6/TkGJ3z/8SL+/U1MxS9vV/jj4jyIX98v
v82+vl5f3s8vj2+aKPQmZSsxaMiQlnWSwcGmaR/WNGG0NQsFp+XOsMcCDuKTl4fro3z/47n/
qyuJKOzj7CojqX07P30X/0CsxCGATPgDNmTGVN9frw/ntyHh8+VPJH1924d71Nc7OA4Xc5fs
Fwl4GczpZnwS+nPbo5MD4A55PK9Ld0639KPadS26qK49V9+FHtHMdegclbWuY4Vp5LhkebqP
Q7FwJd90mwfIQdyI6g4POxkqnUWdl3QVDQY4q2Z9VJxsjiquh8Ywa12Iu6/iXshH28vj+Tr5
cBi34J+U6KESJvtAAPsWWdB3MDfJAhXQeulgLsWqCWxSNwL0SL8WoE/Am9pCwVA6qcgCX5TR
J0QYewEVIjli0I0uBdMhDozTF3NSW01bevacGREF7FE5h6MPi/aKWyegNd7cLpGDaw0lNdKW
B1c5PNXkATrtCfVpRowW9oI7ZvNUL9VyO798kAdtDQkHpFtIoVvwskg7EcAurXQJL1nYs4kC
28G85C7dYEk6engTBIwIbOvAGTeao9Pz+fXUDa2TJ6Jikt3B2jsj9ZOnYVlyTNE6vkd6RyFE
mw6cgNLaLNqlT4WvrX3fIVKWN8vcogM1wDatSwGXyO/0ADeWxcGtxWbSMq+sK8u1SmYTfFcU
O8tmqdzLi4zsAtTejR/StRigRGgEOk+iDR2RvRtvFa75ZjPRpAmSGzLz1F60cPNBU1w/nd6+
TQqKWMv5HhXp2vXRrSoFw709eh4gUF9qRlqvvTyLWfzfZ9BMh8keT2plLOTKtck7FBEMxZfa
wSeVq1AWv78K1QDurbO5wvy08JzteFJweXs4P4H7hSuE0cbah9nNFi4d93LPUb59larcKTQ/
wE2GKMTb9eH4oDqkUsN6nUYj+p5KnTcNe2RpfrCQp8WRkv0EeUPEHHa6jLgGe2rHnK3fSMBc
azk8ByMEcpqqUx52p6xThkNlnVqgm1yIWk6/a7mYoKrP3nzHfzRMYPbYkGX6oTRsattH1/ml
Ltxb3auB+Mfb+/X58n9nOCJQurepXMvnIe5zqS/ndE4opoGjX/khJLr3i0lbsPYkuwx0f8qI
lCvVqZSSnEiZ1ykSRsQ1DvbaYHD+xFdKzp3kHF0PMzjbnSjLl8ZGBiY6dzDMEDHnIZsdzM0n
ufyQiYS6W33KLpoJNprP68CaqoHw4Nj63VcqA/bEx6wjC82ChOPlW3ETxeneOJEyma6hdSR0
u6naC4KqBrOoiRpq9uFyUuzq1LG9CXFNm6XtTohkFThT7xPt5Vq2fuCPZCu3Y1tU0XyweuhG
grfzLG5Xs3W/1u7nAnlN6+1dqMWn18fZL2+ndzEjXd7Pv47Lcry3UjcrK1hqqlgH+sREByw1
l9afBPTFCsNARSXHtasc8XLFejj9/nSe/WP2fn4VU+z76wVsNiYKGFcHw16qH40iJ46N0qRY
fmVZdkEwXzgcOBRPQP+s/05tiVXDnJy2SlC/HCjf0Li28dL7TNSp7vR5BM3697Y22hPo698J
AtpSFtdSDm1T2VJcm1qkfgMrcGmlW+gqY/+oY5oqtUltH5Zm+q6TxDYprqJU1dK3ivwP5vMh
lU6V3OfABddcZkUIyTmY76nF4G08J8SalB/CmYbmq1V9ySlzELFm9svfkfi6FLOpWT7ADuRD
HGLzqECHkSfXPEGvDkb3yfw5ivA1fsfcePXu0FCxEyLvMSLvekaj9kajKx6OCAzh83IWLQm6
pOKlvsDoONIS0ChYErGDnusTCYodMaJXDDq3TasBaYFn2v4p0GFBuMXKDGtm+cEU7rg2dp2V
8R5c7yuMtlWGpyrBIJBRNxRPiiJ05cDsA6pCHVZQzGFQDUWLYYHV1OKdu+vr+7dZKFYsl4fT
y6eb6+v59DJrxq7xKZITRNy0kyUTEuhYpqVuUXnYC3sP2mZdryKxvDRHw2wTN65rZtqhHovq
ruAV7Ni+KUPQ+yxjOA73gec4HHYkRx0d3s4zJmN7GGLSOv77Y8zSbD/RdwJ+aHOsGr0Cz5T/
81+9t4nAScmgzfT26FpSsdR9+tmtcT6VWYbTo72kcfIA82/LHDM1SltVJ1EfWL7fp5h9FUtm
qQIQzcNdHu4+Gy28W20dUxh2q9KsT4kZDQzeSeamJEnQTK1AozPB8s3sX6VjCmAdbDIirAI0
p7ewWQk9zRyZRDcWS2hDn0sPjmd5hlRKTdohIiNNqY1SbotqX7tGVwnrqGhMo/Jtkmme/5vr
9elt9g6bu/8+P12/z17O/5nUE/d5fqeNb5vX0/dv4HCL2DGGG23aED+O6VzvsoBsy+P9wcZY
vUmPTVrol+7aTXgMK/0uiwLkafym3KMr2bpZkvih7H/iWrvZD2hciu5+kAED0S0fycl4f3l+
rJNsDQYEOMObvIb6w3ZrHb5e9RTKcS3dCzBO84HMijCWXg7GI07EN43xRZskP0r3k8yboBBT
XJv/SwuG3m3CQzBoftcEksD5fbQVKoCPi6DO9TMUmLrH/5+xa+luG0fWf8VnVj2LOVckJVm6
98yCAkkJMV8mSInKhsfdcWd8xon7Os4i/35Q4AtVKNqzSazvA0Cg8Cw8qvK2NHsV+12LySqM
Yvvu1owZe1JlTfIbZtHRvnsyYx2tzgEW8o7F30m+O4K16PmcdrTgf/Nbf4YpXsrx7PLv+sf3
P5++/nx9gCNtLCmdGvjIsG9VAZwXzTkOG+ZKlamRY0zqtolSUmDa/LJjeEQuiAAUstJdv7vX
TQwT9y1J71CIk8IQGPySRefIugzzeLL0Hz39+Ov54ddN+fD98Zm0EhPQ2RObmU+R7NJaTxxZ
vMKbMVbs4aJVGu2Rx9c5RKrJ43pjmz+aSf1vCK9HRXc+t94qWQXr/P0PqW28C0M+iDFIkN57
K6/yVIueadBAarUOai+NaaDJOC+S3myP8PD69OXrIxFkb7hFtvqP9hbdkDbjUpMdzNAXhQIz
0OXKOg/QANtnFTpYV6rdFk2S5qoOVJncIZeWPSH3+FEVDEKFOslDOBxeopU6sHrITkrk4XMc
DZyTNEToGYx0mLNYL3SWsBLlkTRR43REZywjAslahTu7BpIDzXR+RbPFAAwzxkFyzEqrDvek
R6bxMRRXMmhHCR39PHuHcujJVPJOz6QhwjOy2mc+L+FOUx4V0/CevD58e7z5/eeff+pRPaKn
RLYcxhmHWNnR05jIIvBwibC8qGVyRVBkbixPNagR48dbKzSTdSKmOiH9BO4WpWmFHt4PhCjK
q85V6BAy08U/pObVr/1R4Co9xZayjVOwhtAdrnXMf1ldFf9lINgvA7H05bIq4Hihg1v5+meT
Z2FZxmCFMuYu0kKpiyqWx7yL80iGOZLmoahPM46kqv/rCdZrkQ6hs1anMROIlByZ34EajJO4
qsxzGZQXpUca3bRIcbMQLPzGiv8AWNVI5fFUo5QgwrAgUYioZWpEWlvOc1Db/dfD65f+oRc9
aYM6N3MeKkuZ+fS3ruqkgFv7Gs3RXShIIi0VvqIB4PUQV3jBbaOmyduJNNDYUdiijHN4/4Az
p7yI2HmGLqUbjwwZyNzF+uXC5CbbTPCyr+QZpw6Ak7YB3ZQNzKcr0XGdaRh1VbQMpAfNVCsb
sslwoxjIq6rlfRNz3JEDkblXK53wbJu7gsyT1eYEuaXv4QUB9qQrnLC+ohF9ghYS0iQN3Akn
yOTjKBWRy7UOxH9LBbjlBU6jpRPJBDnSGeBQiDjFhCTtW6ouWK1omC7wNri9xoUeSyWuxrur
bVBCAwGaQAeAyYWBaZ7PRREVhYfin2u91MFyqfUaDfwXoGqx7xWbIQTHEWGVyTzmMPCRlXXx
2bjHmgZNRIpG1UXGD55gExlnL4O73lBiInhsUNsgSjREXkiTgB570JpjW683ZGA7FmmUSHXC
wuptAOOeFuuelhcZLjtsXflkUBsw887sSBreyNEqO1RaDVanOCbV0RTdnbdftSy6YlEiGwWb
tbdEXrf2qdHUiaDXuUYKAeytLPW2xeaIwKTrZLXy135tH/caIlN6sXhM7I0og9fnYLO6P2NU
pnLv26vuEUR+fgGso8JfZxg7H4/+OvDDNYbdh1qmgNt4G2QkVap3AaY1pWC7T4629j+UTLfA
u4SW+NTuAvvcdpYrL76ZH0Y9tkqIYfGZQQZUZ5gaaLYiZLv92usuaRxxNDXdOTNhVO6QLSxC
3bKUa2kWlWob2EaiCLVnmXKHTDXPjGvJdeZcC6iW3JG5aOtL542/uk1LjjtEW8/uT3qdqOqw
pu96+FUfvKcfl3ri5fuPl2e9uBuU4+HBgPsg+mhMi6nC9suiQf1X7xdPCTD5aUy6fcDrCelz
bL/d4UNBnqWq9dwwvoY+XEcHRJaeZ7ZCnZwhWP+fNlmu/rlb8XxVXNQ//c00OOlZQi81kgSO
aoeUv71D6lzVelWr1RCtoFS2bsaErYqa7D+mxbHAv7QekTd6PQUPZDhCS8zbsoxIm9o35vWn
uU8VTR7Zs52p95OM3Eo+2U+x9A/d4MB23tXYNsyPtfVcQbPI7GDjxJ2Hk/4wAtwDPTybDzua
BIQP12DlBKcRiqppGahLEpSVTut7diVNkG1L0IDK1lYM0mglMSXFjtM7+6Fnj9VFCd9FqDhp
ve1KMSnAhCIGi0qFNDfC3H8hWOmjO4QG65/fYFDL/1jkFfiwtbYiRsyRUAw74yT38DDFfubT
YwUBPt/FV1q1GbZoYMCkIkmdihTZIet/Ozk71ttdQCSjP1kXDW0Od1dSx42ArTqBwUuYIi8E
5hvXqu91CJXgNBJD9UXmpzCnucmVVo9rGj8VxBmzAeOIAnlxJkKFbLvNfUS76NMCoX/Y15Un
3JYpgFWT6RGzDCPfoY779coBL3rRlyqnaoyOkBWNIlLKwmvvRgujEnw+6WGcwAW8KKZtKNPD
uGTqONcKwRFDeiGImpGGyjAHh7FpYbdCC3RKUsa5LkdOslbGdZheczLElOD6UUQsCDt3vzic
UQJtGqmSiIgjxTPCNn9hiDQEw9q5FGQoMBMPKURVCBGS4uoRyJHksBVPQDR+mddMVKDGeSXY
/yMxa2hIeuCPSR4dC4cmk7aFfdNPq1hP9soeFCfIzYKebetPxRWna6NOlFrSnqiHChXTLluf
dHfPKFZpxTHT6yzsfn1Gna81MEd2pb0T0A9Qzqh7kRLbIwOwlbrNYuhzXBW4uCPifPzzNdJz
JR2yelfy3ak5sHivGw+/yESZltPdCGOViVtBGKtOdCVQ2tvaQ4j+wBcldnjRC5Ty9eXt5Y8X
xne0eUl8IKZjx7FpOlFlcwVHHShXxnDcSWvGaMOWvM6mKqgxbkZMXxjLVhUMzKHqTgKXkwTL
cz0AibjL44tlIJt5TgECcV7s9mbCevebw9IYZ23JBropa310gO5y0qNB6qQDlDFaBJRpKA6d
KGJSEwYx2Mk5HmPwS3QYvCmgiiJSuzgCuhgBo0c6CMbeFk2refnxBhoM3HB5hmMWrs2I7W27
WpnKQem2UP88iiz3zKijyE8UsiE+o2edYQYHSyIYjtm8GLSCoxxdC11N6smwdQ3NSellaMSw
TjnG7yyUpWgb31udSjcrUpWet215Itj6LpHohqITcwk9UwXgC9EhClYIxZRlWpiJAb+vv/g4
bDEb9kONFzDFUOnOY/I6wVoABRk3DGVP0cbgwQ7uGu1v3aRGYx3675Ny6Qub2dMlZEAREXer
I6poXwPQmOWAHQKcf5Qfe8DvDzFvxPPDjx/88BwKImm9MMnRdGlKFJFQdTZpibmeBP/3xoix
LrQyE998efwLLkDBqzAllLz5/efbzSG9gxG0U9HNt4df43uAh+cfLze/P958f3z88vjl/7Su
+4hSOj0+/2Xuv30Dpy5P3/98wbkfwpGK7kHOSvFIgf6IllUDYB7/lxkfKQrrMAkP/McSveRB
SwSblCryqd2OkdN/hzVPqSiqVvtlbrPhuU9NVqpTsZBqmIZNFPJckcdkfW+zd2FFW+pIjdYm
tIjEgoR0G+2aw9bfEEE0IWqy8tvD16fvX3mLlFkkHAMoRoWhxrNlSSyp9diZ65kz3sEkqP65
Y8hcL8D0AOFhyrh2pmk1kaAY0xSzuoE15rTnM2ImTfawegpxDMGYHXMaMoWIwBFhhbbXZo7J
ixlfoko4GTLEuxmCf97PkFnpWBkyVV0+P7zpjv3t5vj88/EmffhlHozSaGC+dYuer80pqlIx
cNM65u4NPjgiFSdpXOr2SzgzRGahHl2+WD7JTXhwa1Hk6ZUs2C62f98R6ZrUeEBCgjHEu6Iz
Id4VnQnxgej6BdRouYYsPiF+gZzgTHBvmYshnEnboHfxVXdkahOo/0Di3GGbONI9APRpIwPM
kVR/Sfbhy9fHt/+Jfj48/+MVtryhom5eH///59PrY7/o7oOM+gNcxtXTyeN3uKD/pd8tJx/S
C3FZnuIqTJeF7i91oD4FRkA+160Mfgb3xopLp65gzzyTSsWgvieKCdPfqYU8F5EURLE5Sa2m
xWREHlFdLQuEk/+JaaKFT3TYhz2OlNruv8YF5i11gTKAjsY1EN7wcVRhUxxwGA+1sdiXxpB9
d3LCMiGdbgWtybQhdp3UKHXr0ymceLGZsWkn/RfDcZ1loEKpFY3DElndBegNmcXR7W+LEqdg
7bGM0SZPsbP86FmwKd8fo8eubjimXWp9gbpwGKhhRZDtWDrGFm8tJqkjqWVUsORZok0Oi5Fl
eM8TfPhYN5TFco1kV0s+jzvPp045ZmoT8CI5misNC7m/8HjTsDgMx2WYd6WzkkP8u3GzsmLb
58g3KvR3H4egFvK4IOF/EebwURhv/2GIjzPj7S8fB7n/b8LIj8KsP/6UDpLyg8RdqvimdweW
YjtF3S4NbCbqrllqmuYmCs8U6nZheOs5bwN3ot3NNSsMMipmc22z2M/y8JwttNIy9ZENEosq
arndbfhx5V6EDd/77vWAD3uBLKlKUe5aqk8NXJjwAzIQWixRRHdypoE+rqrwIis9hFInZGOQ
a3Yo+ClkYegxFyo/ITdsFtvqCcTRQofR/rIg6d4MIU9lucxjvu4gmliI18JutFY3+IxIdTo4
S8lRIKrxHFV5qMCab9ZNGd3uktVtwEfrF2aWhol3btnZPs7klnxMQz6Ze8Ooqd3GdlZ0YtOL
N0cpSeNjUeOTSAPTDaJxGhXXW7ENKAdnZ6S2ZUQO/wA0c2qc0gZgztsdy9ymGFLp/85HOruM
MNyNwG0+JRkHR34iPstDBV58SR6LS1hpqRAYvxkzQj8pvZozu16JbLFx8H4xB8d3CZk7rzoc
qZb4sxFDSyoVNmn1//7Go47VTkoK+CPY0EFoZNbIRJ8RAbjW0qI0pmNoUcQpLBQ6lm8EHeLD
mnZdOLFjdmREC3cqyD5KHB7T2EkC/Aj14NQByn/9+vH0x8Nzr3bzPaA8WarvqPxNzPSFfPCG
0opYWjfzRm279yoMIRxOJ4NxSMZ4kzwf7MOyOjydCxxygnrFgLtjNK70A+rgLlOZOVpBoPEd
vmu9LS6ckarWbvSqM764c1+va5AC9PoHowwODKsO2rHgjUWs3uN5EqTWmQs+PsOOm3B5k3X9
7SZlhZvmlulO1txWHl+f/vrX46tuLfOpDW4q47EB3ffqjpWLjZvqBEUb6m6kmSad0VjuJ309
O7spABbQUw3ICBkQDpEYIuOtFnZ7BQI7ynSYRZtNsHVyoKdR37/1WRAM5eNKNYTjd7C4I30+
PiLLPVaFUyP6QPU36JwziFQedPsvCyVrOm24xwNJB86YSbcdGxBFY5ifnPhM0KQrDnTITrrc
/XjsQuWpcJYoOmDsZrw5KDdglUdSUTCDa7fs4UIC/Y8gzVlQyDm6TviDlaSraYn6P+lXRnQU
3y+WhOriGSNfnsoXI8XvMaM8+QC9WBcix0vJDnXJk6hS+CCJbpq6gS6ydOy0qBO98WBxzZnu
i83cWK1LfE1lCLc/cN0C0p3y0iwa8JFwTSZ+DXCiBdiR6tHtQP3g4LTgJjee1pdxk5FfCxyT
H4tld8KW+9cwfNVh5c6t7NBx5DuWiMCLOzuqwarlTlJHw9B3Osdzcn/njQW5co+UoBupR3dE
OHbRwZh6QBuZPdqX6W5hC3MIw40Ex45zn6oX+eaqBw5rljZordVcDugHnFljAI62MSK99c52
8pjZb4r1D7oWKi+Viu/Bb4gVbgBVtLu1LTWOMLUaqVM9pIWtAk/QeJdm5zIHc5dnzolxE9GE
9tYEBB6W7v0JkXE00fua+PDmCkRWERLQBHXDkySl0EWfmS9pNN1nipORJhM6FCX7lTKtk4wj
Cj2VV6GyFUBM1nuPo+C2bS5i9ltteA6WCJ8jEvjf1tIt8ZRVQdoNnFt1ts0FUzky0RNPhEH3
KZZJ2BVRL1NB0hSHW49k6gzuACK3KV/ob07iGqWHawN8F7jxneZiKt12OmUy1ID1MYw16iQo
Ep3kVmtcJOR4u8FtZAOB1Csj58FugRMDXZvK4kzVUjAIvviVPX57ef2l3p7++LerbU5Rmtxs
qFWxajKrm2ZKtw2nv6sJcb7wcUcdv2hakz3mT8wnc6sg7wLbGMvEVkhvmGFWzJRFsoaLhfg6
sbmXZ959zaFmrCN3uA1zqGAXJIdtotMFNhryo9mRNJLRIVyZ99FEtg3sp7gzuqGoeU224sDA
BZH5YwOWItwjL+Y22r+mwgLAD6z6hMtgv14z4Iamm5abTds6Fz8nzrZmNYNOQTS4dZPeoUek
I4heuc2Fs1+dTeg2oGj/gq6D52ANrXb6LG8Aheev1cq27t+nb7/tM0gVH8F8kr3X1tdzpPVL
p3h1sNlTQWTCC253FK1FuN3Y79l6NBWbPTJV2ScRtre3WydlaEC2MS8DFjW6K9XHj/PE95C5
EoPf1ZG/3dNSSBV4SRp4e5qNgejf3ZLeYa6Z/f789P3fv3m9h97qeDC8XoT9/A4mn5j3UDe/
zXfP/077F+wH0uoAk0r2x+vXp69f3b45XMyl48J4X7eWWUwrdOS0BoUvfyFWL1nvFhLN6miB
OcV6lXRAB8WInx9S8Lwom4WUmX4+5XS4OW26sJHX019vcK/jx81bL7S5ZvLHtz+fnt/AGJcx
NXXzG8j27eH16+MbrZZJhlWYK4neseNMEz+PiCzD3NZp+qWdPMhU2p7hQ8+76tE5BEsO7oNH
qf/N9SSbW8uZGTMtRXecd8j+q+9EtjVCizR2GTL4qwyPvQ0RN1AYRYOMPqDnDQsuXFafbJN0
lKHagcXfywMbT7RHexeQMu+kCPyajSnXK2mv7dJ2zVaPJjYf1Vse81Wi8XfyVogK+euzqHNv
aqg8L4ZoVG6/qLMLVhYLYjRMJ/gW0pPLubV4cy2WDaRst5AYr/ksKXtQIwQfBURytij43VVt
zAa+jyM+/UPe1p19tlTVArZF52IB0C/KEHQSeqF85cHx2f7fXt/+WP3NDqDgNOUkcKwBXI6F
VtQauHkajaJZkwcElHmdQHIJyZfBjZ7lwsiYo412jYyNBUZMg6M0W1GGdzyQJ2elOQbe7cps
h7wkDkR4OGw+x/Z7q5lp2RiRwoYpMK6XwJl9NklYoQf8xn7wbfO24xGMd5eoZuNs7S39ET9d
s91myxRJr4O2yPyGRez2XKH6lZNt2Hxkqrud7WptgtVGBFympEo9n4vREz4TpdX4xoVLkezQ
ehkRK67ghlkkdpyo1l694yRlcL4+DveBf+dGUVpN2dtGI0YiyQIvYL5R6Ybn8fjGtkBuh/cZ
QcVZsPKZSq3OO+TlYsroZjqnBa8s73YokMN+QW77hXa8YurY4EzeAV8z6Rt8offt+Za93Xtc
+93frlhZrhdkjP0DoPa+Zpp139eYEusm53tc881EebsnojAmF2HSMrtJU9WAY7cPx7xIBegq
Fs4A2y50Fe0FE6VnprENH05+kAnP54YPjSP7kja+4et9u9t0SZjJ9LpE2xd4EbNnb+5aQW79
3ebDMOv/IswOh7FD9CWAGRC0YjI7DqyZNzl6zALbhfz1iutyRHW3cW4sjBPJjAn1nXdbh1wD
X+9qrmYBD5geDbjt1W7CVbb1uXId7tc7rgNV5UZwXRfaKNNDqX2gqWRlbD+qtHoHMf8zMnkj
2Mnz8zW/z8qxe758/4fWN9/vFKHK9v6WSSoKzzIXTDXAbWhRpAWTYRUIpi7LfdAyhT5Xa4/D
wzrwQ3BNyXJ7r9IZ5soOnAozplod21BTFurdhktKNflWuq1ewy0jkOzMZKbS+mqI9kzn3GR6
te3iojiBp4uAaU6qzkqueYQMCntULSfXT5/XyOTiiKel8NdcBE0EPkfo9Sv7hTo+VszaQuVn
xeSzaNGB04TX22DPzAjtEfnhnnrgbcB1QC2xYHJeALtUvZO+9/uCZUoAtpXmVLUqNb95dzCq
HVrMGakq8MDKMaYbqmsuurod7UTBprWxDn2Rte1iGdS5OD8ii7qADYb2xng4h/3xGEIKy9JC
2ErArJ4xNEJvhyPRtjNiO4LhF1aAqNDzWhLqP5RdW3PjOK7+K3ncrTpTq4sl2Q/9IEuyrbFk
MaLsOP2iyiSebtd24lTiPjvZX38IUheApNJzXtLNDxRJkyABkiCgptcAqQWCWv6sODw9IJv8
cg2PHltt59+IrsoFhv3Ib32aqyxZy0jxgDQUERxWIduF3ZKtuu4ZC2Lg3QYDks1oy8UaCNNJ
9euAyqkBpmEx+R4Cu7caIrsIfNHwZYwaJAgZqUhOCPrx1yNNS2u+DXRPW66xDfJIQCNzJ9us
vRbtUDMbudrZ8D2tubdTo10jey9rlzE2++tQ9G0S11qlyOxNo/B9lx5mWPLjfHq52mYYaYxI
aJEZhgnW1nGeokm73K9MlxayULBQRL/kTqJofu2PvU3xaEHKxYYK6TAqLd/bfnH+8qO5Rkgz
+HywUIRpEPMkz6mB9KZxwy3WFPbk2VBeteQiFQDWica8vqWEtMxKKyHOEgrwrE4q7mvlgs9O
XeICYZc1Ry1rvSevAQRUrlRc4EGjPawEmldluW+be5a5FpVWZhHr4O0K9QiANNXuKlnOOBYS
JYzcI2KFiJmZERacowaXcGL0bECGr0rRvnZ5z+Dqsox38Rqf8MEiLkRQfiAXHSqsQs/bh/Pb
FcJn69KrC75Af8aAGb7lO9IyLooK3wl2eL5j+8ZAS+JZFoG9l3fTJ8zj2+X98uf1ZvPxenr7
7XDz7efp/Wp6t+GNdvDO6pyXHr0bFqtVluZ6Wpe7A6puS8Sslc4a2+3yi+fM5p9kExtknNPR
spY5T8zR6YjLCp9+dyBdWTqwfzak48p6ySOx2HsSF3y0Ywae83iyQSwpIrydRTCOuI3h0Arj
86ARnrtmMyVsLWSO45AOcOnbmhKXrBD9nFeiK+AXTmQQ6qoffk4PfStdcC3xmYBh80elcWJF
xe64NLtX4GKxttUqv7ChtrZA5gk8nNma03hzx9IaAVt4QMJmx0s4sMORFcZuhnu4FKpQbHL3
qggsHBODOMkr12tN/gBantdVa+m2XNqHec42MUhJeIStaWUQSpaENnZLb13PWGTanaA0rdDV
AnMUOppZhSSUlrp7ghuai4SgFfGSJVauEZMkNj8RaBpbJ2Bpq13Ae1uHgGXmrW/gPLCuBPmw
1Oi0uRcEVPAMfSv+3MViA5NWazs1hoJdx7fwxkgOLFMBky0cgsmhbdQHcng0uXgke583zfM+
bZpPApea5MAyaRH5aG1aAX0dkpsLSouO/uR3c9faG5K2cC2LxUiz1QfHD7lLzAV1mrUHeprJ
fSPN1s6OFk6WCYLjc5FiZVQkUj6lh/6n9NybFGhAtIjSBByLJpMtV/LEVmXa0Mi2PXy/k0aK
rmPhnbVQYDbMokIJdftoNjxPmG7uPTTrdlnFderZmvB7be+kLZh87Kllet8LS/hCSrdp2hQl
NZdNRSmnPyptX5VajPIBht9rW7fDwDMFo8QtnQ946NjxyI4ruWDry51ckW0coyg2MVA3aWCZ
jDy0LPcleSQwFg0BFUurQEryeFJAiD6X6g+xNCYcbiHsJJu1kZiy01SY07MJuuo9O03uWUzK
7T5WvovjW2ajy4OHiR+ZNgubUryTX4W2lV7g6d4ceAWvYsveQZF4vi5N7j2U27lt0gvpbE4q
ENl2OW5RQrbq3yI31SS8sn62qtqHfXLUJlhvhOtG7CkW3p4gpIEq3Sb1PWvEWCf06BzTmm0+
SbvLmFEpPqOaRy5phNjozDMEQEoIc81FYd0IHQv//EMThnhAZBo6TdmS5NXN+7XzAjfs+1WA
ycfH04/T2+X5dCWnAXGai/nmYabrId+EFgY0GwLwxi8PPy7fZFDXLvjv4+VFNEGvT8jkEBcD
6TZfxUkmgwcWRVZMkMm7BEEhx8kiTfaUIu1i+1aRJs9Cu9sKgePTQbhY6yD8o/pf9Mf5t6fz
2+kRzvYmfl4T+bQZEtDbrkAVWko523p4fXgUdbw8nv5GF5LNhkzTXxrNBp5IZXuHgMz84+X6
/fR+JuUtSMhymZ590SI5f/t4u7w/Xl5PN+/yasTgISccWGF3uv7n8vZv2Xsf/z29/c9N/vx6
epI/LrH+omAhDyOVce/52/erWYu6aQFT5MJbONj6vhHIX9Ffw5iJ4flfcGV2evv2cSMZHiZE
nuAKsygKCIMDMNOBuQ4sKDDXPxEADRjWg8gKoj69X36A3fQvx9njCzLOHnfJ8qkQd+j33iT6
5jdYBl6eBO++IPd8Kg4RZh2BHNejecbr6eHfP1+hMTJMyvvr6fT4HY2AmB3bPaPTRQBwit1s
2jjZNVgomFSWTFJZVeBYDBp1n0Iw3QnqcsenSGmWNMX2E2p2bD6hTrc3/aTYbXY//WHxyYc0
moBGY9tqP0ltjqye/iHweB0R1QlqC+ISm596CbxggfPMMS/E306OQntfIMaXwXbGqLaBUIDw
QX+R14l5TKvQmOPH5QrDXsYk8jUv8CFAV12Ty1A+XV3d4vz0djk/4ZubjbLcHm4D4l1aVzKm
xB0YdVf1fbsFm/Laci1A4tSIhHYqC4jqSpIJ34/2XSu3POi3N1m7TkuxUcVBxfI6AwdHxtPc
1V3T3MtA403VgDsn6Vl1jCA00hNRS0f2hwufspEmVztlKO4t8HM4RKp2aZ5lCbp8KogvAEjJ
Slh8D/HCv7iCMYIoJHQzXHmxh+g55KV/B1XLVJYn9gVN0XnS+AJakpZPmUZnRwZhSA5wv53h
KEtdLmk/XwgdvM3qGh4Mjvd06x1ixjVvV2wdQ4hYoiqWYuSSYtseix3EEdrefcWxNSAUHp6K
Kt3G69L1wtm2XRUGbZmGoT/DZrAdAUKUzZzlzk6IjFpVTDN/Arfkh5BtLjaKQjgJ5UbwwI7P
JvLPXCs+m0/hoYGzJBWC0OygOp7PI7M5PEwdLzaLF7jrehacp643X1hxYqZJcLOZErd0j8R9
e71+YMGbKPKD2orPFwcDh4jP5Iq2xws+9xyz2/aJG7pmtQKOHAvMUpE9spRzJ6NeVQ1l91WB
nYp0WVdL+KvfU97lReKS45Aeke/EbTDWhQd0c9dW1RJuTJEVQ0ncREOKmhvEedkm5EIVELE2
3VU4rCaAh1mBI02lpdiNlhpCVDcAyLXilkfEuHldZ/fEC0AHtBn3TBDWoBp7mOsJfUhsk0I8
H/Sg9lxsgLHMHMGKLYnHu56ixXLqYfCCZICmK7LhN8mY8yl1/tQT6Qu1HiVdPLTmztIvlHsG
FDNPD1JfBAOKBw90G7GAtodkk+Mzuo0Yk2yInYCvR+sKvLWAoVRNOKwnFOT4oQOZmEqVVsh2
KSMf2R77CdEDd/9inECxHj7bxCD5hHxidcaANfClbSe7vgxBDZ+fxW40+XF5/LcKZg17r1Ep
QtJOtydFJDipihtingIwZ3PXsdVueV6BiNoLC0ThxP8CJuQBWUYpSbuFRJTIsVKSNMkix946
oC28wE7jMuR2wuz1eSXjrr2VYP0l/l3jqNCA31a1YDhbFyoTRRsF+Qwfw/qO5N2RWfRXlEHN
J9un7BhbDcFxljzxvc/Lr467mFtbfkgC+vPFvGtDMOj90NFttYutZeT0qVWfP7lf7/bcxHec
2UDPWvYmF1wWJgffsfONpC+mSGFonwyCFC3myUE/3BzpoeehT+sMvDNucp7jzcN+ac2MJx3s
2SBig5XYeCD6p0ltWZInd2aGvFz/IsdBbIt/kWWTr36RI2s2v8ixTNl0jrlQuCZJkT+SpNni
OuWJNTdQkYrAbtt1krRi4ZpRtCwNOO8yzxzMK/lQRHikaGGg4E1R5g3xFeWAknc/I6rnLUw0
VXkXIbbQALQwUVGC+nFGwao6vJ1BmXVYZV7Y0dBaxMK+Mvfx+YbhUu5gwDw+nFHZp2XYp+Dq
FRZwbKQmjWtdx/qlonnTtJlvp4FVf5skewskVMqDDV7V2Lh3xNcQxdiCl/ujHcaeOkecbaiF
7EDY2drdgm8FO8ysuDW3ljdw8jaGMdL6JTC7KhQ5fdeA5wL2fCvsW+GNFT343IAXooy5Q2HE
dQ0YBbCioIJrv8vZJpf+6dSrgIe3p/88vJ1u+Ov5RSpb2hWL0sD45efb48k0uxRF8johx0Ud
JKTdMjNQaaCj9eSGK/cVY17lZKptmqTVSV3hOW9iofKissRkOkSlfDady6OV8bSsKbNCfGKL
qtKVxxup944btDgvlhXi1l6TbssNvu+qki3EvWhLmhkfQIGTnzpWOZ618rWzOJDwLE20vMrq
N8YvGBQ0RjdUwVHgauD8eCOJN+zh20l6xzBdlaqvwTB23cjgEh9TFNEp8a/I43HZdD45NvyX
GT4p6oB0qmrVahbMaRnXrf5b1KMImhGB2J9I/4j+9Hy5nl7fLo+W1zEZBPfsvJKp3K/P798s
GVnJ0Z5VJuVuq/+OV8nNP/jH+/X0fFOJHc738+s/4VLi8fynGL2Uzr7l2+Xh6fHyLCag5clO
2WzBbYFYhldIugAqNiTUD0HPqet6ZUFZ2aaVYErs3EO0c1JykfxjmHK5jPI6Li0zDYprcIwE
CMwkUexoE9JfsfT4evQWYWRtIGDZYVVnt8MrBZW8WV9EP72Qe7aO1K6rQ+c/EA6LpdeTcbBw
JpbVMOFj4u2OZICzBi62tHYyeFzhLJ78OuZwENwzRd9ywzeZmBl9p0uHzt0PfjY7oc0O4Lzm
Q69Nwn0ZuwrvAa1ZGCvREpcdm2ScIdlf10exK+/CCBqNVZnhprmlEQl6wpF587kB0yOVDuym
6q7xZ1it6qhin+7OgiiyEXwf2xKMuOZxqiNIbZqzUhm4G+S6EZqhHxs4L4MAWyJ3cO+0HC31
8n4GcXh3w4QdOXY9z+EgbVyrcCk5PFZQtwsfJtbiGHsAb1f5ShIp3HkrgkMbVRahqv/iSw70
Da1W/Bec8tUcpsmQxcNZ+J359kPBffaJpik2fv7cwGNZxi62exBpzyPpxA0cFa7IjtIjO0Ih
h3FpTAwsUqHkoZMSkDwpPpBRwEID8Pkqel+pqsO3IrKLmp4QH3M+QYOLzc/o4jfo9O2Rpwst
SX+rgkjHbI/J71vXcbGnysT3qNfOOJrhKdcBtKAe1NxwxhHdKpbxfIbNPgSwCAKhV5MD8g7V
AdzIYzJz8AWJAEJi9cWTmJqQ8mY797EJGwDLOPh/2wK10kIN3qw1aOEAU52QmvJ4C1dLE9OM
aBbR/JH2faR9Hy2I8Uc0x85zRXrhUfoCe8SDl+OwOsVB6lH7IbVsUwx0VXmiReFE3nq4FEzj
BUyuNSNotjtkRcXgbrTJEnIQ329/cXZ4C1sevYCim3w+w74NNkfy6iffxYY1VF4eo5RCQvd3
53q+ohG7ZexQEWQOcd8CgEui0wDih2SuMN/D1q0AzLBvnf7wC558C4EGryVJM8ps13519e4v
Mw5CKK4VOqhg5ZG3BYAWDWwX7yPyxGcUfTkpfMQP1I5MvvONU/117ICPkNx8Js7ctWDYKkth
ruf6cxOcc+Iuo4NDl5rsSpiLJSrQsWiBrYIUNg/nWk0q/Ije+qZIZgG+Hz6sQvlwGWU75Ayi
d4C9AsFVrIX2iC3unl9/CP1eWyjmfjhYtCXfT88yCAs3DNGaIgZX+J3UQJwc39KBOHyd4xkt
JXV3g9PbmdEPLDn69mzOT727ADDAVPcxY6OQFFMKAfWtqpGtIr/ko/XbaDLIOevr1euUAo4z
9FugUl0CDhkg7r0uHGmFdhqRUBqt677uiurnyxXt1XqbQiEfHpSksIuHwAmJfV3ghw5NUwvQ
YOa5ND0LtTQx4AuChVer5+U6qgG+Bji0XaE3q3UTz4Bcjol0hGUqpENXS9NCdZnlU4vcOXnI
l7KqgSeI5lJNwDL0fLyqiGU4cOlCHcxxJ4pVeBbhuzIAFnhZVtM9HR/VwyR4+vn8/NFtwylb
qlAq2YHck0neUXtNzVpNpyill1Mlm2QYlH/ZmBXEvD29PH4Mlq//BQPJNOX/YkVBj+7kudDD
9fL2r/T8fn07//ET7HyJoaxy3qacSH1/eD/9VogPT083xeXyevMPUeI/b/4canxHNeJSVkIQ
D6rS37evpbwOEHHB1kOhDnl00hxrPgvIBmDthkZaV/olRjgcLVzr+7oiynnJ9r6DK+kA62qi
vrZq6JI0rcBLskV/z5u1r67i1AJ9evhx/Y7ERY++XW/qh+vppry8nK+0y1fZbEbmmwRmZKb4
josq+fl8fjpfPyzDV3o+FrnppsGa1yYFTRAJo03DPTwFVVqzTVEYHZBmjz/jeUTUekh7Q3Nz
wepXcMn8fHp4//l2ej69XG9+im4w+G7mGEw2oxvKXOOf3MI/ucE/2/IYEgX0AFwSSi4hG3pM
IOyDCDZJVPAyTPlxCrfyYk8zyoMf3pJ3IxjVFp0JC3ZwrtPGBcfd+buYRGSfHBdigcYuF2OW
8gW5rpYIubJbblxi1w1pPEaJUDtdbKsHAHmvKnQ78sayFKI2oOkQbyPXzIuZ4KfYcdDRCbXR
xw9BJeJiQYJ397hPEC52TWj4fuexUH+xVzVWO8QlfV+94V6/qcmzKjF3Z/QFX8XglSTKwkRd
nkMxnrvuDM+oZuv7+MCiSbg/w6YqEsAuRfsWwpMF4tVTAnMKzAJsb7jngTv3sMeSZFfQX3HI
yiJ0omGSlw/fXk5XdSRkYcctvcqVaayibJ3FArNmd/RTxuudFbQeFEkCPcqI1747cc4DubOm
KsVGt6YSpUz8wMPmqd2MleXbxUPfps/IFunRj9GmTII5duSpEejP1YnowUf+8vjj/DI1DHgD
sEvEfsjy61EedVTY1lUTd8Fn/87TD/jJm1peEdq3GDIQVL1njZ2sNq6ffN+AXRuYG058L51D
jiSi+rxerkL6nI2jyxR8W+AjAqGcEotjBWD1VSinrq+pr2QWNawQUtubaoLoOywBi5ItOttW
pfO9nd5BWlom05I5oVOuMf8zj8pJSOtzRGKGtOl3mssYRzwjKyPxX79hpJ9Y4RI7D5nWDhkV
RicmK3z6IQ+IjbFKawUpjBYkMD/SOUhvNEatwlhRSMlNQLSyDfOcEH34lcVCrIUGQIvvQTRF
pcR+gWdi5shyfyEPzjoOuPx1fgY9DxzZPp3f1ZM946siT+Na/G2yFod04scF8VHB65U0lFRz
+PT8ChsQK4MJXs/LVoYtrpJqT8N6FceFExLBUzIHH7bLNBqRRkxILNpkGguXXbMkiZbluzWr
dmuKNhWOwS3zZfVKywNvNagno0OZyfhpnb4kkjfLt/PTN8tNGWRN4oWbHLGjVUAbDhHUKLaK
t8Opgyz18vD2ZCs0h9xCRwpw7qnbOsi7Jy72AWF5hVoEJpcfKKH7kQdI2VdsCgixR0yegTic
E1M4KRiPXGy1K1G1QFAQDn5XjVbsJl9iN/8A5XiZAkAGCPIpBnfj4IyOojIKDz7qBRAc8GlI
53+vYXtK6P1sUohlWtftdzO8Ita3cPdOLFjadZ7I90S7+os7aIhw6NTGOL5Iw8VmxWmJb7qc
xRDUDlvuq7PJRvoKwtNTRffNWZU0+I2Wst9MVJDmAt/5KUrcbKKFDi6zWkh3He2OaXRYHlvr
oMWYRxF4lcAzJwOWva2D0ivt2EE5cGoCF7gZCfKqcg9WUBqurA30ssGfsGFi1Ru7+qHmjQUT
Q3UpOTqmzlT88nUdt0tW2uydVziokUjIyU8s9QEUOseBvq8T4F0NC3MGViolpYzW/mq539zf
8J9/vEsjlHFB6PwV0ljfEJdbmR7D5TbmckLAhwrK628UAJ7A0zYIkKOX2d3xlLmMp51mFS25
P+eDC3USnxuI7Bi33nxXytjrEyTaWBk8sONs+q4DtSVlekt6g25ZmvmdGmD6IgPw/o6/a8Mw
/GNdMxkgW5CtZuso39H1/k6+wAvM8sxfKFaCjA7DYAKU73aVZYRHEyH41E4Cj5TaMMCROXgd
EGqrA2Os99xIn1npmp9j9Um+mTmR2dvyukpGf+eTBJ1NGgF3b8wxO9cQxjjGt7YAKxN9Sw/s
uGdB5SI3X1pHX6gMcrbYhgnsiRLsb7PEZh2l8tzzf41dW1McOw7+KxRPu1WbhIGBwEMe3N2e
mc70jb4MAy9dhDMnUAmQ4rKH/PuV7L5ItppNVarIfFK73b7IsixLHLCXdeyc3j1h8H+jt91b
y58fZ7Kk9xvqVZNFeICVjO4W3t1je9OYLFLd1eMgxmdhDQknaX0wzP1vd5iU6z+3/9j/DFls
kjjINlGcEmEVJGuTZaZI6ZVqTMlDL5hj7qZExUQ1QQ562Q9/jMQNLw1/4jFwCypnXbiEXvK4
cpRThQfx7NUpEdUNvWjoSYwZlOcLXvYwlRxmWzBKIbGq9pDCIVVUV4If/k15GON5U4ZjCjKJ
JuR4sy5ZNAV1j/CROaBLkbcSUZCYUrm1VC6LJ44qAsbf+Pvu+ytsMzCGiefyatSIe/oLUzrE
9MTSgOmyHLSOSUqrqNwYqKglSC+ytwn7GbaoYn9aAtjTV8VedXf/+hMPbHyHz1WBp0Is+baF
3NzPFB26eRQsVTHGG1jcYVAMowo80yqhmyyVRnpbH7Ir8B3QblVNL7f2MKba3rYqTHxSpcOm
ZJnxgHLkFn40XcrRZClzt5T5dCnzd0rRmQmBxKIn9I9M0pxQvF+DiKym+MvlwCz2QQjKLw2q
pDG9GeaKrwTQCRww4MYVJ84WuUDz+4iShLahZL99vjp1+yoX8nXyYbeZkBHtfui5T9anrfMe
/H3e5DS73FZ+NcJlzX87L10uKj6aO6DFLMIY7SJKyPICE99h75E2P6Sr9AAP7r9tpwELPPjR
lfsSGykiVdUa7z6LRLoBD2p3qPSI1DADzQwjI1CXvH8GjrJB/6IMiOaWgvdKpz0tqCqTmW9c
eePEbbjFoVNfA2BTsO/q2NyB28PCt/Ukf8wZiv1i6RXSdLY0cz8gzr7q0KFixt0t+y1KGDQP
0Tf2SJeAPi9obWK8UGEHH72IkkV4Sf1ygs6rP7ZpleV1vCBtELlAbAFrARrLUy5fj3TZRdES
lsZVFefUFd+ZluYnxivAjLfWCI+hzsjOowSwY7tQZca+ycLO+LJgXWqqSi3Sut3MXIB6uOFT
YU06RTV1vqj4KoE6FwNCpoTlG10m6pJP/wEDYRnFJYyQFv70Okl4fXO7Y6upI+Q7wBUBPbwC
WZgvS5X6JG8FsXAe4CgFlZrenjEkHDj02wbMixw/Uuj77QdFH0Bh/RRtIqMveOpCXOVnJycH
fF3Ik1iT2lwBE50NTbRg/Pg7SwbzaZRXnxaq/pTV8isXVmKMunYFTzBk47Lg7/7aT5hHulCg
mM2PPkv0OEejCdqO9u+eH09Pj88+zPYlxqZekDwxWe2INwM4LW2w8qL/0uJ59/rX497f0lea
dZ1ZXBFYGz80jm1SAUQjGB3+BsTPbtMcZDvN9WJIsAlJolITWbfWZUbf7xiA67TwfkrC0BIc
ab5qliAjAlpAB5k6Upsb/nFaFsbqRpV8DGCOAjOEL2HNpXEv8lJlS+2UoCIZsH3TYwv3vUbe
yhBu/isnSNjKeR5+F0kzhYnLtltxA7grsNc8rprmLsU90pV04OHGoOheOxmpmDQC5CBbLiy1
gi2nKj3YHwEDLiqQvZ4kaJFIgp20OUwzAcvMCli5LFcsa6/FkqvchcwZsgc2gTFsDwac7q0Y
zLTN8kwLRhzKAotc3lVbLAKTbYhmPcq0UBvYj0OVhZdB/Zw+7hEMB4431yLbRkTm9gysEQaU
N5eFFbYNuWzqPiOpTyEsHbRe1XmjqpWEWL3Gro70KiEj2wVWulTYs0UaPxSaNFsmckEdhwno
Lba6yInqDmYPfOfVzogecN6WA5xczUU0F9DtlQDOjYUsMHFirrTAoNNAR5GOBNKiVMsU7/p1
2gcWcDQsl+6GCzP0bbnak7qyrHCA82w796ETGXIkWOkVbxGMMIR31i6t3ky712VI60jOCOoW
lNcrKS2oYQNx0r+oXxtBHaJ+8/a36eJBCtFqdXTo1YEsG/B7vrnIx7lC14zT4ebCsQui7jZO
tstqw+WEKzfsVDbynkxxv4v0NneXGYM4bKyxurhl8rqcueoS/KYavPl95P7mC4XB5pynuqC2
K8vRzjyEnCMWWS9uQLFnUUkNxY4IjoHSLfJinDmxpL4erXHtxplo3J3aOOquN3/Z/7F7etj9
/Pj49H3feyqNQSfnkraj9Uskxg/Xidu8vXglIG55bFIs2Bo6/eFqq4sqYp8QQQ95PRBhN7mA
xDV3gIKplwYybd21HadUYRWLhL7JReL7DRRNb/ShuTGAN+g4OWkCrJ370/0u/PJh0WT9312V
GYVzk5Ussq753S6pU1GHofzqMly6zzsDHhD4YiykXZfBsVeS08UdivF225KlMAx1seJ7Yws4
Q6pDJTUujNnjsW/4GrFDB7zQCsN+tStYvhxSU4QqcV7jrsUGM1VyMK+C3l54wNwqRVPvrtLA
5QUIvaA56E/HsOAiMDR7KFyrarxKyq0jlmrjzXrmIEus6jL3URx7bKYbNAdN00erFL4vyj08
SzxIb+uSR02LFN9TuXssv7WV1CxnvFXMT4lFGnOW4O8beP2Tqt/ES3t8JPdGgnZOHf8Y5fM0
hbodM8op9Wp3KIeTlOnSpmpwejL5HnpJwaFM1oB6djuU+SRlstb0LrNDOZugnB1NPXM22aJn
R1Pfczafes/pZ+d74irH0UHTtLEHZoeT7weS09Qmcalc/kyGD2X4SIYn6n4swycy/FmGzybq
PVGV2URdZk5l1nl82pYC1nAMU+6Cjq4yHw41bNdCCc9q3VCH44FS5qBMiWVdlnGSSKUtlZbx
Uuu1D8dQKxZhZiBkTVxPfJtYpbop13G14gRjehwQPLGiP/gx+drolXu31zc/7h6+99fFfj3d
Pbz8sF6/97vn736GX2OqX7fcQBLarQiG5030RieDHB1MqdYOJnAMEd8xcnBfuk3vOx5WXGYq
jUP+AeHj/a+7n7sPL3f3u72b293Nj2dT7xuLP/lV73KJ4wEDFAW7q1DVdFvc0dOmqt1zVdgo
p/ZJljUVVta4gAmMfrB0F1NqFdlAVhUx2TcZaNkRsgY5XXiMXMgvMmpV80/2VlAmRlhxamYZ
K6uposEzVSxDukuxn59nyaX7dUVuTma8OuTo/mE1LwwtU5D4WalCB1XYxJXnIjgYxW3Tfjl4
m0lcrreCfTFamo1ia2/57O4fn37vRbtvr9+/2xFLmw/UDgylTxVpWwpSMatvOEno+70fkbxf
oFWqnKtcHG+zvDsYneS40mXuvt4e0FQTsBD6jNMXePI1QTMXWCZLNjHDJ2hl2JhxNkW31q+2
z1s3weW059DlVdIEPSvd8CDsbAEs1yb1EfinHLVvIJWBABbLRaKWXtldnowYOs4bGXaYwxAt
vMeqVVyO8cVwMO7h5ejXX1b4rK4fvtP7EaCQN8UY0WQ0zoOwwzxQqUmH0rEVMIrCP+FpNypp
9Niwtvx2hT6mtapY99r5N5DM4MAd8ezwwH/RyDZZF4fFrcrF+ZjhlEwH5ESrPDviZrBbkCX2
tR3qWkHPR9521YDc28VgzqiyfOhdvoZBGsmiFF+51rqwU97em8F784Pk2fvXcxcb8/k/e/ev
L7u3Hfxn93Lz8ePHf9MIc1gabKDTptZb7Y8keAO3KnYDU2ZXdY5LYJVA1Vxa76OiingQHKQA
41wAww90Bu2EmLy4sO8TkpyYZqpLdk7fCWY70SdgWPwSzSK1dpWMfWkG9ZVgar+0iPE5iAWp
FpY6Ao0uVuNBMQgxtkyM1tUy32iUcZL5vsDDXSMAvXVQbjrDqsuFAE8/QCnQl/kFXv/iMuhd
tk4zOnqf+U8K/PPSQujOjMbtf5dNKhOFKQynJBnm8+GMFcZHGUL63LMK2A4HAWM1ktLRRSzZ
etKANoCHItT1AaqwAhmWNGZk17r3/if7/26MYbIdc021N/+NxtxUZiIHIgsY/u+Vx8zg6Nn8
f7imfY5UnFSJCjhiNQ9H3zGEVK2hzfR5w5QKQzIXW22/OM+k4cQjCxQaFGO1FLRXl2OULmhj
t9NtmKiY8igLL+tcuhBjskYsmsyWY4qgLgSGagtOjZ5iOoQmqrLEkMve0mS0co62CWja9KK3
qlo58/pg9h717vmFKaTJOqpZZgIzSVDQwUpe1uLJj51HDrWjrU3s5Iq635GVeWhHFOGuyAnQ
Q8pN8YXSDVbbVqB1Ch4H7dJzMhcWCVVdZjBGVBydOA+ZD1rpbdTQVKP2M2vTsCudFCxzrCGu
gVrTgAgGNfvChQMGcY0eyRxsGppOxkAlmottOGCneoruoO2L8LYSmfJRqsyy6sgi26Pr1H15
hapjXly6NS3cuvvpcGwBVnqOR6465d3dNaCqQRfA/BnEB8So1W2kaoVhqfCWuxUY44k2ZqDV
8smjKs3WMAP1vQlgoOGuJmuSRHQzADrZ1Rp2lcTLLGUBZ7tyGmoZjzF6+rKEhQI2CLOTNHBI
1hFwpa5UGdG1Pq7MlmKzKmrniU4NSIttuFqKNKKwV7ub1ye81uzZBkxb/ibToILpiifjQMDR
Sn2aSnTgjZzm79weevw3KbiNVm0ORSrHJWU4g4pSXZnLgDAxqF7lG6x7ZCEV0yeEmqS020WZ
CuRC0RsEiUlggFl6Y4zdG5VfTo6Pj4aceEbCmvuDGXwsjngc8HbNUWyTYzjNwPLY6bD0iJJ6
Zkc8cqAbjBUd5Esksv2s/U/P3+4ePr0+757uH//afbjd/fxF7hwNbQCyLc5YQgKHMu6B/oTH
3c54nN2QfqesSJuAmO9wqE3obpw9HrPHgUUcUzZ1lTrwmVMVSuPG4HhjJVs2YkUMHUbXsIbL
HKoocL+Fh1cqkWoLK0x+mU8SzB1odDgu0JRUl5fcCicxNxHot+gyPzs4nE9xwrpWE9d8TAEp
fgXUH9aF/D3SH3T9wMqPL2W6b47y+dxtsMzQeeFLze4wdkZaiRObpqD3ul1KZ/WJBI5LldIU
rP4lgwGyIwQ3FhIRlI001SgjHRk7shDZXDKbHSkFRwYhsLrBap/C5hV3NkUI2ni0hfFDqSgc
yybRzL0HCbVOMSmE5ASIZDSadBzuk1W8/H9P92acoYj9u/vrDw+jSwhlMqOnWqmZ+yKX4fD4
RNQFJN7jmXzl2OO9KBzWCcYv+8+31zP2Afa+epEncXjJ+wTt6SIBBjAon9TYYPpichQAsV/Q
7c0Fe6LeOYE1IMVgJMN8qHATFzGXVXw2SExyu6qWi8ap0G6PD844jEi/GO1ebj792P1+/vSG
IPTiR3oDln5SXzG+mdfUJgo/WvRwgJ2WUXsZwRzEd/LX+EFUnC5UFuHpyu7+e88q2/emsIQO
w8PnwfqII8ljtTL6z3h7QfZn3JGS4iG7bDBCdz/vHl7fhi/eopjHfWPl7oCcfJ0GA909pDsB
i25pxF4LFefyhgo3riwjI+iXea/Khk+/f7087t08Pu32Hp/2rFpDEvEYZtDKlixTDIMPfRxt
//cC6LMGyTqMixVLxuNQ/Iccv50R9FlLOrlGTGQc1kqv6pM1UVO1XxeFzw2gXzZ6aArVqZSH
RSvvaR0KIOw81VKoU4f7L+Phejj3sGlyrMEd13IxOzxNm8R73GzYJNB/fWH+esy41ThvdKO9
B8wff4SlE7hq6pWmia47nFsa+hbNlnE23KtWry+3GOvs5vpl99eefrjB6YJ3wf+5e7ndU8/P
jzd3hhRdv1x70yYMU6/8pYCFKwX/Dg9gabrk+Zc7hkqfx94Uhs5fKRDrQ/yVwATmxe3Js1+V
IPSbsfZ7Hc8S/fcEHpaUFx5W4EtccCsUCKveRWlMLl2ysOfbqWqnyi9ylSr/Y7bSyzfpGGk5
uvu+e37x31CGR4f+kwaW0Hp2EMULfx5wI1DfIlMdmkZzATv2p2wMfawT/Ovxlykm8RZhFjto
gEFRk2CW97wfcFbv80AsQoCPZ35bAXzkT7llOTvzeY2213dUePfrlmeD6xcQX/wA1tJYDj2c
NUHsjztVhn6zw0p8sYiFzusJXhT6fjCoVCdJrAQCen5MPVTV/nBA1O+bSPufsJBl5RptXb7k
q2CbrITu7QWOIGi0UIouC5s8x5Wf/rfXF7nYmB0+NsvgfINRIlnk8OHrF2aP4kmeq9wbBqdz
f0zhjRgBW42Z1q4f/nq838te77/tnvp45lJNVFbFbViUNJ5fX8kyMLk0GpkiSipLkVQYQwlr
f+VGgveGrzEmo0c7BrMUkzXdpPebIrSixBqoVa/ZTHJI7TEQRRXQ7Oz4+XpPuaDq/jACNiZM
X6hUOvSFMaJXkuJNniriMN+GWtBAkFod+2oY4jbi4JS2QDiEeTlSa2najmQQiyI1ZLNabeIm
dbCR9zz0pwXicbqsdSh3LNKHjMhiBVY6qWgscULbxGVNSdyEYiJ1jV1KiEUTJB1P1QSczewQ
Q13iuSV60LXm6JzeHF6H1efB40+m2rMeTeMQ2e1uoe2lG3ORFMuPx3RzIUZz/9vodM97f2NA
q7vvDzaSqHEAZKdwaR7hIQNaV/A9+zfw8PMnfALYWtjWfvy1ux/twOYi0rTlwKdXX/bdp+2W
mzSN97zHYe/czQ/OBvv6YHoQKjNMtCDOkMMei9Ep1cV5/fZ0/fR77+nx9eXugWpndmNJN5xB
XJcaGrtidqnRdD/Spftxpnuo614fMzDDqIp1TI29QzjBMHZjCfWkSZia+tOiCyVGRi7WFK8w
dedAxuWl1Ezbg016GNdsXoYztnaHra8jwsvrpuVPHbGdEPwUDkY7HCaRDi5PuYwklLmcpt6y
qPLCMQk6HIGcw7YMibd2Ege+phye0uNpays3bYh7WlX3DS/2eBblKf3koSlgLR8vP95T1N6g
5bi5KwlLSsKmiUF7BWI8kSL3JjlKSib4XKiH0SBkXCxle4Ww+7vdnp54mInUV/i8eAbpgYqe
wI1YvWroYWhHQK8kv9wg/OphfPSNH9Qur2LmLzYQAiAcipTkitrECYHeP2b8+QQ+9+eycE5Y
avTKy5Oc6d0UxdPVU/kBfOE7pBnpriAkq2tgRntmj/wVdd6uQUhXGqeDhLVr7s8w4EEqwouK
hjOsmdsu88Sg63CVh7Dex0YGl9QTHjQEFJI6dSG8V9gy4Yl4ZDpyNITiQQRGr88L6V4xklFh
4IGIbKAk4WAmLBoMS9Xmi4Xx5mEU2J/SykTndI1I8oD/EgRolvC7e0nZtE7QnDC5wizP5L15
GdH9Np5dj41dnuO2ntQjLWJ+J9//RqAvIiLjMJwlRgqsano00IQY46LmGsMiz2r/xieilcN0
+nbqIXTcGujkjd4cNNDnt9ncgTCGaiIUqKBpMgHHK/3t/E142YEDzQ7eZu7TmIverymgs8O3
QyJbKvSvTOgxRoXxTanzXecmULU2OzY7acTBFekip893vj+jVun47YBmlOo2A6HKXIxsqu/B
feB/TZSNm1/kAgA=

--k1lZvvs/B4yU6o8G--
